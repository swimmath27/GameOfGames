//
//  PlayGameViewController.swift
//  GameOfGames
//
//  Created by Michael Lombardo on 5/31/16.
//  Copyright © 2016 Michael Lombardo. All rights reserved.
//

import UIKit

class PlayGameViewController: UIViewController {

  // True when round roulette has just been played and we're
  // back in this controller to actually start the new round
  static fileprivate var wasNewRound:Bool = true;
  
  @IBOutlet weak var roundLabel: UILabel!
  
  @IBOutlet weak var team1NameLabel: UILabel!
  @IBOutlet weak var team2NameLabel: UILabel!
  
  @IBOutlet weak var Team1ScoreLabel: UILabel!
  @IBOutlet weak var Team2ScoreLabel: UILabel!

  @IBOutlet weak var Team1CardsLabel: UILabel!
  @IBOutlet weak var Team2CardsLabel: UILabel!
  
  @IBOutlet weak var messageTitleLabel: UILabel!
  @IBOutlet weak var messageLabel: UILabel!
  
  @IBOutlet weak var nextPlayerLabel: UILabel!
  
  @IBOutlet weak var upNextLabel: UILabel!
  
  @IBOutlet weak var drawCardButton: UIButton!
  
  
  fileprivate var game:Game = Game.getInstance();
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    team1NameLabel.text = game.getTeamName(1);
    team2NameLabel.text = game.getTeamName(2);
    
    Team1ScoreLabel.text = "\(game.getTeam1Score()) Pts";
    Team2ScoreLabel.text = "\(game.getTeam2Score()) Pts";

    Team1CardsLabel.text = "\(game.getTeamCardsInCurrentRound(1)) Cards";
    Team2CardsLabel.text = "\(game.getTeamCardsInCurrentRound(2)) Cards";

    roundLabel.text = "Round \(game.getCurrentRound())"
    
    nextPlayerLabel.text = game.getCurrentPlayerName() + ",";
    
    messageTitleLabel.text = game.messageTitle;
    messageLabel.text = game.message;
    
    if (self.timeForRoundRoulette()) {
      // it's actually a "new round" but we need to display
      // the previous round cards before round roulette
      Team1CardsLabel.text =
          "\(game.getTeamCardsInLastRound(1)) Cards";
      Team2CardsLabel.text =
          "\(game.getTeamCardsInLastRound(2)) Cards";

      // reusing the labels
      nextPlayerLabel.textAlignment = .center;
      nextPlayerLabel.text = "End of Round, Tap to"
      upNextLabel.text = "go to Round Roulette"

      drawCardButton.setImage(
          UIImage(named: "rollButton.png"),
          for: UIControlState());
    }
    else {
      // normal gameplay
      if game.isNewRound() {  // Just got back from round roulette
        // no win message right now
        messageTitleLabel.text = ""
        messageLabel.text = ""

        // check for a win condition
        let whoWon: Int = self.determineAWinner();
        if (whoWon == 1) {
          drawCardButton.isHidden = true;
          nextPlayerLabel.text = "";
          upNextLabel.text = "\(game.getTeamName(1)) Win!"
        } else if (whoWon == 2) {
          drawCardButton.isHidden = true;
          nextPlayerLabel.text = "";
          upNextLabel.text = "\(game.getTeamName(2)) Win!"
        }
        else if !game.hasNextCard() {
          drawCardButton.isHidden = true;
          upNextLabel.text = "Deck is Out of Cards!"
        
          //reusing these labels...
          nextPlayerLabel.textAlignment = .center;
          if (game.getTeam1Score() > game.getTeam2Score()) {
            nextPlayerLabel.text =
                "\(game.getTeamName(1)) Win!";
          }
          else if (game.getTeam1Score() < game.getTeam2Score()) {
            nextPlayerLabel.text =
                "\(game.getTeamName(2)) Win!";
          }
          else {
            nextPlayerLabel.text = "Tie Game!";
          }
        }  // !game.hasNextCard
      }  // game.isNewRound
      else {
        // not a new round anymore
        PlayGameViewController.wasNewRound = false
      }

      // make current team's font larger
      if game.getCurrentTeam() == 1  {  // team 1 is up
        team1NameLabel.font = UIFont(descriptor: team1NameLabel.font.fontDescriptor, size: 27)
        team2NameLabel.font = UIFont(descriptor: team1NameLabel.font.fontDescriptor, size: 22)
      }
      else  {  // team 2 is up
        team1NameLabel.font = UIFont(descriptor: team1NameLabel.font.fontDescriptor, size: 22)
        team2NameLabel.font = UIFont(descriptor: team1NameLabel.font.fontDescriptor, size: 27)
      }

    } // normal play
    self.view.layer.insertSublayer(UIHelper.getBackgroundGradient(), at: 0)
  }  // ViewDidLoad

  // TODO: replace this with an enum?
  // team1won, team2won, tiedWinConditions, NoWinner
  // display something like "The game is still tied, continuing..."
  // under tiedWinConditions
  func determineAWinner() -> Int {
    if (game.getTeam1Score() >= Game.NUM_CARDS_TO_WIN) {
      if (game.getTeam2Score() >= Game.NUM_CARDS_TO_WIN) {
        // both teams could win
        if (game.getTeam1Score() > game.getTeam2Score()) {
          // team 1 won
          return 1
        }
        else if (game.getTeam2Score() > game.getTeam1Score()) {
          // team 2 won
          return 2
        }
        //else {}  // tied win conditions
      }
      else {
        // team 1 won
        return  1;
      }
    }
    else if (game.getTeam2Score() >= Game.NUM_CARDS_TO_WIN) {
      return 2;
    }
    // no outright winner
    return 0;
  }

  func timeForRoundRoulette() -> Bool{
    return game.isNewRound() &&
      !PlayGameViewController.wasNewRound;
  }

  @IBAction func drawCardButtonPressed(_ sender: AnyObject) {
    if (self.timeForRoundRoulette()) {
      PlayGameViewController.wasNewRound = true;
      performSegue(withIdentifier: "PlayGameToRoundRoulette", sender: nil)
    }
    else if game.hasNextCard() {
      _ = game.drawCard()
      performSegue(withIdentifier: "PlayGameToDrawCard", sender: nil)
    }
    else {
      alert("Deck is out of cards");
    }
  }
  
  @IBAction func viewTeam1CardsButtonPressed(_ sender: AnyObject) {
    viewTeamCards(1);
  }
  
  @IBAction func viewTeam2CardsButtonPressed(_ sender: AnyObject) {
    viewTeamCards(2);
  }
  
  
  func viewTeamCards(_ which:Int) {
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
  
  func alert(_ s : String) {
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
