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

  @IBOutlet weak var team1RoundCards: UILabel!
  @IBOutlet weak var team2RoundCards: UILabel!

  @IBOutlet weak var team1Chance: UILabel!
  @IBOutlet weak var team2Chance: UILabel!

  @IBOutlet weak var team1ScoreRound: UILabel!
  @IBOutlet weak var team2ScoreRound: UILabel!

  @IBOutlet weak var team1ScoreAfter: UILabel!
  @IBOutlet weak var team2ScoreAfter: UILabel!
  
  @IBOutlet weak var team1Shots: UITextField!
  @IBOutlet weak var team2Shots: UITextField!
  
  @IBOutlet weak var instructionsLabel: UILabel!
  
  @IBOutlet weak var rollButton: UIButton!
  
  let game : Game = Game.getInstance()
  
  var rolled:Bool = false;

  var team1CurrentCards:Int = 0;
  var team2CurrentCards:Int = 0;

  var team1NumShots:Int = 0;
  var team2NumShots:Int = 0;

  var team1TotalCards:Int = 0;
  var team2TotalCards:Int = 0;
  
  @IBOutlet weak var buttonHeight: NSLayoutConstraint!
  @IBOutlet weak var buttonWidth: NSLayoutConstraint!
  
  var delay:Double = 0.01;
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    alert("It is the end of round \(game.getCurrentRound()-1). It is time to roll to see who drinks the center cup");
    
    self.rolled = false;


    team1Name.text = "\(game.getTeamName(1))"
    team2Name.text = "\(game.getTeamName(2))"
    
    //chance that team 1 drinks is proportional to the number of cards team 2 got
    //need the last round version because current it is the next round
    team1CurrentCards = game.getTeamCardsInLastRound(1)
    team2CurrentCards = game.getTeamCardsInLastRound(2)

    team1TotalCards = game.getTeamScore(1)
    team2TotalCards = game.getTeamScore(2)

    team1RoundCards.text = "\(team1CurrentCards)"
    team2RoundCards.text = "\(team2CurrentCards)"

    self.view.layer.insertSublayer(UIHelper.getBackgroundGradient(), at: 0)

    team1Shots.text = "0"
    team2Shots.text = "0"
    team1ShotsChanged(team1Shots)
    team2ShotsChanged(team2Shots)
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  @IBAction func team1ShotsChanged(_ sender: UITextField) {
    if let x:String = team1Shots.text {
      if let num: Int = Int(x) {
        if num > game.getNumPlayers() / 2 {
          alert("Can't take more shots than you have players");
          team1Shots.text = "\(team1NumShots)";
        }
        else {
          team1NumShots = num;
          let roundScore = team1NumShots*team1CurrentCards
          team1ScoreRound.text = "\(roundScore)"
          team1ScoreAfter.text = "\(roundScore+team1TotalCards)"
        }
      }
    }
  }

  @IBAction func team2ShotsChanged(_ sender: UITextField) {
    if let x:String = team2Shots.text {
      if let num: Int = Int(x) {
        if num > game.getNumPlayers() / 2 {
          alert("Can't take more shots than you have players");
          team2Shots.text = "\(team2NumShots)";
        }
        else {
          team2NumShots = num;
          let roundScore = team2NumShots*team2CurrentCards
          team2ScoreRound.text = "\(roundScore)"
          team2ScoreAfter.text = "\(roundScore+team2TotalCards)"
        }
      }
    }
  }

  @IBAction func rollButtonPressed(_ sender: AnyObject) {
    var team1RoundScore = 0
    if let x:String = team1Shots.text {
      if let num : Int = Int(x) {
        self.team1NumShots = num
        team1RoundScore = num*team1CurrentCards
      }
    }
    var team2RoundScore = 0
    if let x:String = team2Shots.text {
      if let num : Int = Int(x) {
        self.team2NumShots = num
        team2RoundScore = num*team2CurrentCards
      }
    }
    alertToConfirm("Are you sure?", msg: "\(self.game.getTeamName(1)) shots: \(team1NumShots)\n\(self.game.getTeamName(2)) shots: \(team2NumShots)", action: { action in
        self.game.addTeam1Score(team1RoundScore)
        self.game.addTeam2Score(team2RoundScore)
        self.performSegue(withIdentifier: "RoundRouletteToPlayGame", sender: nil)
    })
  }

  @IBAction func team1touchdown(_ sender: Any) {
    team1ShotsChanged(team1Shots)
  }

  @IBAction func team2touchdown(_ sender: Any) {
    team2ShotsChanged(team2Shots)
  }

  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    team1Shots.resignFirstResponder()
    team2Shots.resignFirstResponder()
    team1ShotsChanged(team1Shots)
    team2ShotsChanged(team2Shots)
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
    let popup = UIAlertController(title: "Alert",
                    message: s,
                    preferredStyle: UIAlertControllerStyle.alert)
    
    let cancelAction = UIAlertAction(title: "OK",
                     style: .cancel, handler: nil)
    
    popup.addAction(cancelAction)
    self.present(popup, animated: true,
                   completion: nil)
    
  }

  func alertToConfirm(_ title: String, msg : String, action : @escaping (UIAlertAction) -> Void) {
    let popup = UIAlertController(title: title,
                                  message: msg,
                                  preferredStyle: UIAlertControllerStyle.alert)

    let okAction = UIAlertAction(title:"OK", style: .default, handler: action);
    popup.addAction(okAction)

    let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
    popup.addAction(cancelAction);

    self.present(popup, animated: true,
                 completion: nil)
  }

}
