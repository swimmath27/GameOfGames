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
  
  static fileprivate var wasNewRound:Bool = true;
  
  @IBOutlet weak var roundLabel: UILabel!
  
  @IBOutlet weak var team1NameLabel: UILabel!
  @IBOutlet weak var team2NameLabel: UILabel!
  
  @IBOutlet weak var Team1ScoreLabel: UILabel!
  @IBOutlet weak var Team2ScoreLabel: UILabel!
  
  @IBOutlet weak var messageTitleLabel: UILabel!
  @IBOutlet weak var messageLabel: UILabel!
  
  @IBOutlet weak var nextPlayerLabel: UILabel!
  
  @IBOutlet weak var upNextLabel: UILabel!
  
  @IBOutlet weak var drawCardButton: UIButton!
  
  
  fileprivate var game:Game = Game.getInstance();
  
  override func viewDidLoad()
  {
    super.viewDidLoad()
    
    team1NameLabel.text = game.getTeamName(1);
    team2NameLabel.text = game.getTeamName(2);
    
    Team1ScoreLabel.text = "\(game.getTeam1Score())";
    Team2ScoreLabel.text = "\(game.getTeam2Score())";
    
    roundLabel.text = "Round \(game.getCurrentRound())"
    
    nextPlayerLabel.text = game.getCurrentPlayerName() + ",";
    
    messageTitleLabel.text = game.messageTitle;
    messageLabel.text = game.message;
    
    if (game.isNewRound())
    {
      if !PlayGameViewController.wasNewRound
      {
        
        nextPlayerLabel.textAlignment = .center;
        nextPlayerLabel.text = "End of Round, Click to"
        upNextLabel.text = "go to Round Roulette"
        
        drawCardButton.setImage(UIImage(named:"rollButton.png"), for: UIControlState());
      }
    }
    else
    {
      PlayGameViewController.wasNewRound = false
      
      if game.getCurrentTeam() == 1 // team 2 is up
      {
        team1NameLabel.font = UIFont(descriptor: team1NameLabel.font.fontDescriptor, size: 27)
        team2NameLabel.font = UIFont(descriptor: team1NameLabel.font.fontDescriptor, size: 22)
      }
      else // team 2 is up
      {
        team1NameLabel.font = UIFont(descriptor: team1NameLabel.font.fontDescriptor, size: 22)
        team2NameLabel.font = UIFont(descriptor: team1NameLabel.font.fontDescriptor, size: 27)
      }
      
      //check if game is over
      if (game.getTeam1Score() >= Game.NUM_CARDS_TO_WIN)
      {
        drawCardButton.isHidden = true;
        nextPlayerLabel.text = "";
        upNextLabel.text = "\(game.getTeamName(1)) Win!"
      }
      else if (game.getTeam2Score() >= Game.NUM_CARDS_TO_WIN)
      {
        drawCardButton.isHidden = true;
        nextPlayerLabel.text = "";
        upNextLabel.text = "\(game.getTeamName(2)) Win!"
      }
      else if !game.hasNextCard()
      {
        drawCardButton.isHidden = true;
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
    }
    
    
    self.view.layer.insertSublayer(UIHelper.getBackgroundGradient(), at: 0)
  }

  @IBAction func drawCardButtonPressed(_ sender: AnyObject)
  {
    if (game.isNewRound() && !PlayGameViewController.wasNewRound)
    {
      PlayGameViewController.wasNewRound = true;
      performSegue(withIdentifier: "PlayGameToRoundRoulette", sender: nil)
    }
    else if game.hasNextCard()
    {
      _ = game.drawCard()
      performSegue(withIdentifier: "PlayGameToDrawCard", sender: nil)
    }
    else
    {
      alert("Deck is out of cards");
    }
  }
  
  @IBAction func viewTeam1CardsButtonPressed(_ sender: AnyObject)
  {
    viewTeamCards(1);
  }
  
  @IBAction func viewTeam2CardsButtonPressed(_ sender: AnyObject)
  {
    viewTeamCards(2);
  }
  
  
  func viewTeamCards(_ which:Int)
  {
    CheckCardsViewController.whichTeam = which;
    performSegue(withIdentifier: "PlayGameToCheckCards", sender: nil)
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
  
  func alert(_ s : String)
  {
    let popup = UIAlertController(title: "Error",
                    message: s,
                    preferredStyle: UIAlertControllerStyle.alert)
    
    let cancelAction = UIAlertAction(title: "OK",
                     style: .cancel, handler: nil)
    
    popup.addAction(cancelAction)
    self.present(popup, animated: true,
                   completion: nil)
    
  }


}
