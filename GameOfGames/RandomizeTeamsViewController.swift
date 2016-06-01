//
//  RandomizeTeamsViewController.swift
//  GameOfGames
//
//  Created by Michael Lombardo on 5/31/16.
//  Copyright © 2016 Michael Lombardo. All rights reserved.
//

import UIKit

class RandomizeTeamsViewController: UIViewController
{

    @IBOutlet weak var team1ListLabel: UILabel!
    @IBOutlet weak var team2ListLabel: UILabel!
    
    var playerOrder:[Int] = [Int]();
    
    var game:Game = Game.getInstance();
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.playerOrder = [Int]()
        
        var i = 3; // 3 is the first variable player; 1 and 2 are captains
        while i <= game.getNumPlayers()
        {
            self.playerOrder.append(i);
            i += 1;
        }
        
        updateTeamViews();
    }

    func updateTeamViews()
    {
        
        var team1List = "1"
        var team2List = "2"
        for i in playerOrder
        {
            print(i);
        }
        
        for i in 0...(playerOrder.count-1)
        {
            
            if i%2 == 0// evens -> team 1 (cuz 0 indexing)
            {
                team1List = team1List + ", \(playerOrder[i])"
            }
            else // odds, team 2
            {
                team2List = team2List + ", \(playerOrder[i])"
            }
        }
        
        team1ListLabel.text = team1List
        team2ListLabel.text = team2List
    }
    
    @IBAction func RandomizeButtonPressed(sender: AnyObject)
    {
        playerOrder.shuffleInPlace();
        updateTeamViews();
    }
    
    @IBAction func FinishButtonPressed(sender: AnyObject)
    {
        var team1List = [1]
        var team2List = [2]
        for i in 0...(playerOrder.count-1)
        {
            if i%2 == 0 // evens -> team 1 (cuz 0 indexing)
            {
                team1List.append(playerOrder[i])
            }
            else // odds -> team 2
            {
                team2List.append(playerOrder[i])
            }
        }
        game.setTeams(team1List, team2: team2List);
        
        performSegueWithIdentifier("RandomizeTeamsToPlayGame", sender: nil)
    }
}
