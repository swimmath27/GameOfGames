//
//  PlayGameViewController.swift
//  GameOfGames
//
//  Created by Michael Lombardo on 5/31/16.
//  Copyright © 2016 Michael Lombardo. All rights reserved.
//

import UIKit

class PlayGameViewController: UIViewController {
    
    @IBOutlet weak var team1NameLabel: UILabel!
    @IBOutlet weak var team2NameLabel: UILabel!
    
    @IBOutlet weak var Team1ScoreLabel: UILabel!
    @IBOutlet weak var Team2ScoreLabel: UILabel!
    
    @IBOutlet weak var nextPlayerLabel: UILabel!
    
    @IBOutlet weak var drawCardButton: UIButton!
    @IBOutlet weak var upNextLabel: UILabel!
    
    @IBOutlet weak var nextPlayerTeamLabel: UILabel!
    
    @IBOutlet weak var roundLabel: UILabel!
    
    private var game:Game = Game.getInstance();
    override func viewDidLoad() {
        super.viewDidLoad()
        
        team1NameLabel.text = game.getTeamName(1);
        team2NameLabel.text = game.getTeamName(2);
        
        Team1ScoreLabel.text = "\(game.getTeam1Score())";
        Team2ScoreLabel.text = "\(game.getTeam2Score())";
        
        roundLabel.text = "Round \(game.getCurrentRound())"
        
        nextPlayerLabel.text = game.getCurrentPlayerName();
        nextPlayerTeamLabel.text = game.getCurrentTeamName();
        if (game.getTeam1Score() >= Game.NUM_CARDS_TO_WIN)
        {
            drawCardButton.hidden = true;
            nextPlayerLabel.text = "";
            nextPlayerTeamLabel.text = "";
            upNextLabel.text = "Team 1 (\(game.getTeamName(1))) Wins!"
        }
        else if (game.getTeam2Score() >= Game.NUM_CARDS_TO_WIN)
        {
            drawCardButton.hidden = true;
            nextPlayerLabel.text = "";
            nextPlayerTeamLabel.text = "";
            upNextLabel.text = "Team 2 (\(game.getTeamName(1))) Wins!"
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
