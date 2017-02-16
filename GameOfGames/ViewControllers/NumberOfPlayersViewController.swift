//
//  FirstViewController.swift
//  GameOfGames
//
//  Created by Michael Lombardo on 5/31/16.
//  Copyright © 2016 Michael Lombardo. All rights reserved.
//

import UIKit

class NumberOfPlayersViewController: UIViewController
{

  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var questionLabel: UILabel!
  @IBOutlet weak var playerCountField: UITextField!
  
  @IBOutlet weak var setNamesButton: UIButton!
  @IBOutlet weak var quickStartButton: UIButton!
  
  fileprivate var game:Game = Game.getInstance();
  
  override func viewDidLoad()
  {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view, typically from a nib.
    playerCountField.placeholder = "\(Game.MIN_PLAYER_COUNT)-\(Game.MAX_PLAYER_COUNT)"
    
    playerCountField.becomeFirstResponder();
    //background gradient
    self.view.layer.insertSublayer(UIHelper.getBackgroundGradient(), at: 0)
  }

  override func didReceiveMemoryWarning()
  {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

//  override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?)
//  {
//    playerCountField.resignFirstResponder()
//  }
  
  func checkAndSetPlayerCount() -> Int
  {
    if let x:String = playerCountField.text
    {
      if let num : Int = Int(x)
      {
        if (num%2 == 1 && num > 0)
        {
          alert("Teams must be even (if you have an odd number, two people play as one and switch off in odd/even rounds (see rulebook)");
        }
        else if (num < Game.MIN_PLAYER_COUNT)
        {
          alert("You need at least \(Game.MIN_PLAYER_COUNT) players");
        }
        else if num > Game.MAX_PLAYER_COUNT
        {
          alert("You can't have more than \(Game.MAX_PLAYER_COUNT) players");
        }
        else
        {
          return num;
        }
      }
    }
    alert("You must enter a number of players")
    return -1;
    
  }
  
  @IBAction func submitPlayerCount(_ sender: AnyObject)
  {
    let num = checkAndSetPlayerCount()
    if num != -1
    {
      game.setNumPlayers(num);
      alertToConfirm("Start", msg: "Start Game by setting all players and team names", action:
        {
          action in self.performSegue(withIdentifier: "NumPlayersToNamePlayers", sender: nil)
        })
      
    }
  }
  
  @IBAction func quickStartPressed(_ sender: AnyObject)
  {
    let num = checkAndSetPlayerCount()
    if num != -1
    {
      game.quickStart(num)
      alertToConfirm("Quick Start", msg: "Start the game without entering the names of players and teams", action:
        {
          action in self.performSegue(withIdentifier: "NumPlayersToQuickStartRandomizeTeams", sender: nil)
      })
    }
  }
  
  
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
  
  func alertToConfirm(_ title: String, msg : String, action : @escaping (UIAlertAction) -> Void)
  {
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

