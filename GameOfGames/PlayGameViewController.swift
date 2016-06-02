//
//  PlayGameViewController.swift
//  GameOfGames
//
//  Created by Michael Lombardo on 5/31/16.
//  Copyright © 2016 Michael Lombardo. All rights reserved.
//

import UIKit

class PlayGameViewController: UIViewController
{
    
    @IBOutlet weak var roundLabel: UILabel!
    
    @IBOutlet weak var team1NameLabel: UILabel!
    @IBOutlet weak var team2NameLabel: UILabel!
    
    @IBOutlet weak var Team1ScoreLabel: UILabel!
    @IBOutlet weak var Team2ScoreLabel: UILabel!
    
    @IBOutlet weak var upNextLabel: UILabel!
    
    @IBOutlet weak var nextPlayerLabel: UILabel!
    @IBOutlet weak var nextPlayerTeamLabel: UILabel!
    
    @IBOutlet weak var drawCardButton: UIButton!
    @IBOutlet weak var undoButton: UIButton!
    
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
        
        //can't undo skipping a card
        if (game.cardWasSkipped() || (game.getCurrentTurn() == 1))
        {
            undoButton.hidden=true;
        }
        else
        {
            undoButton.hidden=false;
        }

        //check if game is over
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
            upNextLabel.text = "Team 2 (\(game.getTeamName(2))) Wins!"
        }
        else if !game.hasNextCard()
        {
            drawCardButton.hidden = true;
            nextPlayerTeamLabel.text = "";
            upNextLabel.text = "Deck is Out of Cards!"
            
            //reusing these labels...
            if (game.getTeam1Score() > game.getTeam2Score())
            {
                nextPlayerLabel.text = "Team 1 (\(game.getTeamName(1))) Wins!";
                
            }
            else if (game.getTeam1Score() < game.getTeam2Score())
            {
                
                nextPlayerLabel.text = "Team 2 (\(game.getTeamName(2))) Wins!";
            }
            else
            {
                nextPlayerLabel.text = "Tie Game!";
            }

        }
        ///
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
    
    private func undo()
    {
        //shuffles the last card back into the deck
        game.undoLastTurn();
        undoButton.hidden = true;
    }
    
    @IBAction func undoButtonPressed(sender: AnyObject)
    {
        let message:String = "Card will be shuffled back into the deck and it will be the previous player's turn";
        
        let popup = UIAlertController(title: "Error",
                                      message: message,
                                      preferredStyle: UIAlertControllerStyle.Alert)
        
        let okAction = UIAlertAction(title:"OK", style: .Default, handler:
            {
                action in self.undo();
        })
        popup.addAction(okAction)

        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .Cancel, handler: nil)
        
        popup.addAction(cancelAction)
        self.presentViewController(popup, animated: true,
                                   completion: nil)

        game.undoLastTurn();
    }
    
    @IBAction func viewTeam1CardsButtonPressed(sender: AnyObject)
    {
        viewTeamCards(1);
    }
    
    @IBAction func viewTeam2CardsButtonPressed(sender: AnyObject)
    {
        viewTeamCards(2);
    }
    
    
    func viewTeamCards(which:Int)
    {
        CheckCardsViewController.whichTeam = which;
        performSegueWithIdentifier("PlayGameToCheckCards", sender: nil)
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
