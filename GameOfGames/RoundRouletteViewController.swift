//
//  RoundRouletteViewController.swift
//  GameOfGames
//
//  Created by Michael Lombardo on 6/1/16.
//  Copyright © 2016 Michael Lombardo. All rights reserved.
//

import UIKit

class RoundRouletteViewController: UIViewController {

    @IBOutlet weak var team1Name: UILabel!
    @IBOutlet weak var team2Name: UILabel!
    
    @IBOutlet weak var team1Chance: UILabel!
    @IBOutlet weak var team2Chance: UILabel!
    
    @IBOutlet weak var instructionsLabel: UILabel!
    
    @IBOutlet weak var rolledNumber: UILabel!
    @IBOutlet weak var chosenTeam: UILabel!
    
    @IBOutlet weak var rollButton: UIButton!
    
    let game : Game = Game.getInstance()
    
    var rolled:Bool = false;
    
    var team1Cards:Int = 0;
    var team2Cards:Int = 0;
    var totalCards:Int = 0;
    
    @IBOutlet weak var buttonHeight: NSLayoutConstraint!
    @IBOutlet weak var buttonWidth: NSLayoutConstraint!
    
    var timer:NSTimer?
    
    var delay:Double = 0.01;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        alert("It is the end of round \(game.getCurrentRound()-1). It is time to roll to see who drinks the center cup");
        
        self.rolled = false;
        
        team1Name.text = "\(game.getTeamName(1))"
        team2Name.text = "\(game.getTeamName(2))"
        
        //chance that team 1 drinks is proportional to the number of cards team 2 got
        //need the last round version because current it is the next round
        team1Cards = game.getTeamCardsInLastRound(1)
        team2Cards = game.getTeamCardsInLastRound(2)
        
        totalCards = team1Cards+team2Cards;
        
        if (totalCards > 0)
        {
            if (team2Cards > 0)
            {
                let flstring = String(format:"%.2f", 100*Double(team2Cards)/Double(totalCards))
                team1Chance.text = "1-\(team2Cards) (\(flstring)%)"
            }
            else
            {
                //team 2 got no cards, team 1 chance is 0
                team1Chance.text = "0 (0%)"
            }
            
            if (team1Cards > 0)
            {
                let flstring = String(format:"%.2f", 100*Double(team1Cards)/Double(totalCards))
                team2Chance.text = "\(team2Cards+1)-\(totalCards) (\(flstring)%)"
            }
            else
            {
                //team 1 got no cards, team 2 chance is 0
                team2Chance.text = "0 (0%)"
            }
            
            rolledNumber.text = ""
            chosenTeam.text = ""
            
            rollButton.setTitle("Roll", forState: .Normal)
        }
        else
        {
            //nobody has won any cards... just go back
            
            team1Chance.text = "0"
            team2Chance.text = "0"
            
            rolledNumber.text = ""
            
            chosenTeam.text = "Nobody has won any cards this round"
            rollButton.setTitle("Continue", forState: .Normal)
            self.rolled = true;
        }
        
        self.view.layer.insertSublayer(UIHelper.getBackgroundGradient(), atIndex: 0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func timerFire(thisTimer:NSTimer)
    {
        //print("\(delay)")
        
        //print("timer interval: \(timer!.timeInterval)")
        if (delay > 0.75)
        {
            //done with the rolling
            let rand = Int(arc4random_uniform(UInt32(totalCards)))+1
            rolledNumber.text = "\(rand)";
//            rollButton.setTitle("Continue", forState: .Normal)
            rollButton.setImage(UIImage(named:"nextButton.png"), forState: .Normal)
            buttonWidth.constant = 64;
            buttonHeight.constant = 40;
            rollButton.hidden = false;
            
            let team = game.getTeamName(rand <= team2Cards ? 1 : 2)
            chosenTeam.text = team
            
            game.messageTitle = "Too bad, \(team)"
            game.message = "You must finish the Bitch Cup before the game may continue"
        }
        else
        {
            
            let rand = Int(arc4random_uniform(UInt32(totalCards)))+1
            rolledNumber.text = "\(rand)";
            
            //update delay rule
            delay *= (1.0+delay)
            //delay *= 1.1
            
            timer = NSTimer.scheduledTimerWithTimeInterval(delay,
                                                           target: self,
                                                           selector: #selector(RoundRouletteViewController.timerFire(_:)),
                                                           userInfo: nil,
                                                           repeats: false)
        }
    }

    @IBAction func rollButtonPressed(sender: AnyObject)
    {
        
        if (self.rolled)
        {
            performSegueWithIdentifier("RoundRouletteToPlayGame", sender: nil);
        }
        else
        {
            self.rolled = true
            
            timer = NSTimer.scheduledTimerWithTimeInterval(delay,
                                                           target: self,
                                                           selector: #selector(RoundRouletteViewController.timerFire(_:)),
                                                           userInfo: nil,
                                                           repeats: false)
            rollButton.hidden = true;
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func alert(s : String)
    {
        let popup = UIAlertController(title: "Alert",
                                      message: s,
                                      preferredStyle: UIAlertControllerStyle.Alert)
        
        let cancelAction = UIAlertAction(title: "OK",
                                         style: .Cancel, handler: nil)
        
        popup.addAction(cancelAction)
        self.presentViewController(popup, animated: true,
                                   completion: nil)
        
    }

}
