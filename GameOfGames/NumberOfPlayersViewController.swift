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
    
    private var game:Game = Game.getInstance();
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        playerCountField.placeholder = "\(Game.MIN_PLAYER_COUNT)-\(Game.MAX_PLAYER_COUNT)"
        
        playerCountField.becomeFirstResponder();
        //background gradient
        self.view.layer.insertSublayer(UIHelper.getBackgroundGradient(), atIndex: 0)
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

//    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?)
//    {
//        playerCountField.resignFirstResponder()
//    }
    
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
    
    @IBAction func submitPlayerCount(sender: AnyObject)
    {
        let num = checkAndSetPlayerCount()
        if num != -1
        {
            game.setNumPlayers(num);
            performSegueWithIdentifier("NumPlayersToNamePlayers", sender: nil)
        }
    }
    
    @IBAction func quickStartPressed(sender: AnyObject)
    {
        let num = checkAndSetPlayerCount()
        if num != -1
        {
            game.quickStart(num)
            performSegueWithIdentifier("NumPlayersToQuickStartRandomizeTeams", sender: nil)
        }
    }
    
    
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

