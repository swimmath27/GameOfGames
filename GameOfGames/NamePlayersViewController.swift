//
//  NamePlayersViewController.swift
//  GameOfGames
//
//  Created by Michael Lombardo on 6/1/16.
//  Copyright © 2016 Michael Lombardo. All rights reserved.
//

import UIKit

class NamePlayersViewController: UIViewController
{

    @IBOutlet weak var askPlayerNameLabel: UILabel!
    @IBOutlet weak var playerNameField: UITextField!
    
    private var game : Game = Game.getInstance();
    private var currentPlayer : Int = 1;
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        askPlayerNameLabel.text = "What is Team Captain 1's name?"
        playerNameField.text = "";
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func submitButtonPressed(sender: AnyObject)
    {
        if let s : String = playerNameField.text
        {
            if s != ""
            {
                game.setPlayerName(currentPlayer,name: s);
                currentPlayer += 1;
                if currentPlayer > game.getNumPlayers()
                {
                    // all players have been named now
                    performSegueWithIdentifier("NamePlayerstoRandomizeTeams", sender: nil)
                }
                else
                {
                    if (currentPlayer == 2)
                    {
                        askPlayerNameLabel.text = "What is Team Captain 2's name?"
                    }
                    else
                    {
                        askPlayerNameLabel.text = "What is Player \(currentPlayer)'s name?";
                    }
                    playerNameField.text = "";
                }
                return;
            }
        }
        alert("player \(currentPlayer) must have a name");
        
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
