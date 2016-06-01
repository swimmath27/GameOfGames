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

    @IBOutlet weak var playerCountField: UITextField!
    
    private var game:Game = Game.getInstance();
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?)
    {
        playerCountField.resignFirstResponder()
    }
    
    
    @IBAction func submitPlayerCount(sender: AnyObject)
    {
        if let x:String = playerCountField.text
        {
            if let num : Int = Int(x)!
            {
                if (num%2 == 1)
                {
                    alert("Teams must be even");
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
                    game.setNumPlayers(num);
                    performSegueWithIdentifier("NumPlayersToRandomizeTeams", sender: nil)
                }
                return;
            }
        }
        alert("You must enter a number of players")
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

