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
    @IBOutlet weak var team1Table: UITableView!
    @IBOutlet weak var team2Table: UITableView!
    
    var game:Game = Game.getInstance();
    
    var shuffled:Bool = false;
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        team1Table.delegate = self
        team1Table.dataSource = self
        
        team2Table.delegate = self
        team2Table.dataSource = self
        
        updateTeamViews();
        
        self.view.layer.insertSublayer(UIHelper.getBackgroundGradient(), atIndex: 0)
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
        
        let cell = tableView.dequeueReusableCellWithIdentifier("TempCellView", forIndexPath: indexPath) as UITableViewCell
        
        let playerNumber: Int = game.getTeam(tableView == team1Table ? 1 : 2)[row];
        
        cell.textLabel?.text = game.getPlayerName(playerNumber)
          
        cell.textLabel?.textColor = UIColor.whiteColor();
        cell.textLabel?.font = UIFont(name: "Lobster1.3", size: 22)
        cell.textLabel?.textAlignment = .Center
        
        return cell;
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
