//
//  PlayGameViewController.swift
//  GameOfGames
//
//  Created by Michael Lombardo on 5/31/16.
//  Copyright © 2016 Michael Lombardo. All rights reserved.
//

import UIKit

class PlayGameViewController: UIViewController {

    @IBOutlet weak var Team1ScoreLabel: UILabel!
    @IBOutlet weak var Team2ScoreLabel: UILabel!
    
    @IBOutlet weak var nextPlayerLabel: UILabel!
    
    @IBOutlet weak var drawCardButton: UIButton!
    @IBOutlet weak var upNextLabel: UILabel!
    
    private var game:Game = Game.getInstance();
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Team1ScoreLabel.text = "\(game.getTeam1Score())";
        Team2ScoreLabel.text = "\(game.getTeam2Score())";
        
        nextPlayerLabel.text = "Player \(game.getCurrentPlayer())"

        if (game.getTeam1Score() >= Game.NUM_CARDS_TO_WIN)
        {
            drawCardButton.hidden = true;
            nextPlayerLabel.text = "";
            upNextLabel.text = "Team 1 Wins!"
        }
        else if (game.getTeam2Score() >= Game.NUM_CARDS_TO_WIN)
        {
            drawCardButton.hidden = true;
            nextPlayerLabel.text = "";
            upNextLabel.text = "Team 2 Wins!"
        }
        
        // Do any additional setup after loading the view.
    }

    @IBAction func drawCardButtonPressed(sender: AnyObject)
    {
        if game.hasNextCard()
        {
            performSegueWithIdentifier("PlayGameToDrawCard", sender: nil)
        }
        else
        {
            alert("Deck is out of cards");
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        let popup = UIAlertController(title: "Error",
                                      message: s,
                                      preferredStyle: UIAlertControllerStyle.Alert)
        
        let cancelAction = UIAlertAction(title: "OK",
                                         style: .Cancel, handler: nil)
        
        popup.addAction(cancelAction)
        self.presentViewController(popup, animated: true,
                                   completion: nil)
        
    }


}
