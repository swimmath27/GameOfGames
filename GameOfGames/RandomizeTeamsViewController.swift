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
    
    var shuffled:Bool = false;
    
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
        shuffled = true;
    }
    
    @IBAction func FinishButtonPressed(sender: AnyObject)
    {
        //don't need anything here anymore
        if shuffled
        {
            performSegueWithIdentifier("RandomizeTeamsToNameTeams", sender: nil)
        }
        else
        {
            alertToConfirm("Are you sure you want to continue without shuffling teams?",
                           action:
                           {
                                action in self.performSegueWithIdentifier("RandomizeTeamsToNameTeams", sender: nil)
                           })
        }
    }
    
    func alertToConfirm(msg : String, action : (UIAlertAction) -> Void)
    {
        let popup = UIAlertController(title: "Alert",
                                      message: msg,
                                      preferredStyle: UIAlertControllerStyle.Alert)
        
        let okAction = UIAlertAction(title:"OK", style: .Default, handler: action);
        popup.addAction(okAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        popup.addAction(cancelAction);
        
        self.presentViewController(popup, animated: true,
                                   completion: nil)
    }
    
    ///////////////////////////// table view stuff ////////////////////////////////////
    
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
        
        var cell:UITableViewCell? = nil;
        var playerNumber: Int = -1;
        if tableView == team1Table
        {
            cell = tableView.dequeueReusableCellWithIdentifier("TempCellView1", forIndexPath: indexPath) as UITableViewCell

            playerNumber = game.getTeam(1)[row];

            
        }
        else if tableView == team2Table
        {
            cell = tableView.dequeueReusableCellWithIdentifier("TempCellView2", forIndexPath: indexPath) as UITableViewCell
            
            playerNumber = game.getTeam(2)[row];
            
        }
        
        if playerNumber == -1
        {
            return UITableViewCell()
        }
        
        cell!.textLabel?.text = game.getPlayerName(playerNumber)
        
        cell!.backgroundColor = UIColor.clearColor();
        cell!.textLabel?.textColor = UIColor.whiteColor();
        
        return cell!;
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
