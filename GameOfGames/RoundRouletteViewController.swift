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
    
    @IBOutlet weak var rolledNumber: UILabel!
    @IBOutlet weak var chosenTeam: UILabel!
    
    @IBOutlet weak var rollButton: UIButton!
    
    let game : Game = Game.getInstance()
    
    var rolled:Bool = false;
    
    var team1Cards:Int = 0;
    var team2Cards:Int = 0;
    var totalCards:Int = 0;
    
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
            var flstring = String(format:"%.2f", 100*Double(team2Cards)/Double(totalCards))
            team1Chance.text = "1-\(team2Cards) (\(flstring)%)"
            
            flstring = String(format:"%.2f", 100*Double(team2Cards)/Double(totalCards))
            team2Chance.text = "\(team2Cards+1)-\(totalCards) (\(flstring)%)"
            
            rolledNumber.text = ""
            chosenTeam.text = ""
            
            rollButton.setTitle("Roll", forState: .Normal)
        }
        else
        {
            //nobody has won any cards... just go back
            chosenTeam.text = "Nobody has won any cards this round"
            rollButton.setTitle("Continue", forState: .Normal)
            self.rolled = true;
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
            
            let rand = Int(arc4random_uniform(UInt32(totalCards)))+1
            rolledNumber.text = "\(rand)";
            rollButton.setTitle("Continue", forState: .Normal)
            if (rand <= team2Cards)
            {
                chosenTeam.text = game.getTeamName(1)
            }
            else
            {
                chosenTeam.text = game.getTeamName(2);
            }
            
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
