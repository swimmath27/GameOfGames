//
//  RandomizeTeamsViewController.swift
//  GameOfGames
//
//  Created by Michael Lombardo on 5/31/16.
//  Copyright © 2016 Michael Lombardo. All rights reserved.
//

import UIKit

class RandomizeTeamsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate
{
    
    var game:Game = Game.getInstance();
    
    @IBOutlet weak var team1Table: UITableView!
    @IBOutlet weak var team2Table: UITableView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        team1Table.delegate = self
        team1Table.dataSource = self
        
        
        team2Table.delegate = self
        team2Table.dataSource = self
        
        updateTeamViews();
    }

    func updateTeamViews()
    {
        team1Table.reloadData();
        team2Table.reloadData();
    }
    
    @IBAction func RandomizeButtonPressed(sender: AnyObject)
    {
        game.shuffleTeams();
        updateTeamViews();
    }
    
    @IBAction func FinishButtonPressed(sender: AnyObject)
    {
        //don't need anything here anymore
        performSegueWithIdentifier("RandomizeTeamsToNameTeams", sender: nil)
    }
    
    /// table view stuff ////////////////////////////////////
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1;
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if tableView == team1Table
        {
            return game.getTeam(1).count;
        }
        else if tableView == team2Table
        {
            return game.getTeam(2).count;
        }
        else
        {
            return 0;
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let row = indexPath.row
        
        if tableView == team1Table
        {
            let cell = tableView.dequeueReusableCellWithIdentifier("TempCellView1", forIndexPath: indexPath) as UITableViewCell

            let playerNumber : Int = game.getTeam(1)[row];

            cell.textLabel?.text = game.getPlayerName(playerNumber)
            
            return cell;
        }
        else if tableView == team2Table
        {
            let cell = tableView.dequeueReusableCellWithIdentifier("TempCellView2", forIndexPath: indexPath) as UITableViewCell
            
            let playerNumber : Int = game.getTeam(2)[row];
            
            cell.textLabel?.text = game.getPlayerName(playerNumber)
            
            return cell;
        }
        
        return UITableViewCell()
    }
    
    func tableView(tableView: UITableView,
                   didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        //nothing when they select names
        
        //unselect this cell
        if tableView.cellForRowAtIndexPath(indexPath) != nil
        {
            tableView.deselectRowAtIndexPath(indexPath, animated: true)
        }
    }
    
    
    /////////////////////////////////////////////////////////////////////////////////

}
