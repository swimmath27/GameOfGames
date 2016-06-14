//
//  QuickStartRandomTeamsViewController.swift
//  GameOfGames
//
//  Created by Michael Lombardo on 6/3/16.
//  Copyright © 2016 Michael Lombardo. All rights reserved.
//

import UIKit

class QuickStartRandomTeamsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate
{
    @IBOutlet weak var team1Table: UITableView!
    @IBOutlet weak var team2Table: UITableView!
    
    var playerOrder : [Int] = [Int]()
    var team1List : [Int] = [Int]()
    var team2List : [Int] = [Int]()
    
    let game : Game = Game.getInstance()
    
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
        
        updateTeamsFromOrder();
        
        team1Table.delegate = self
        team1Table.dataSource = self
        
        
        team2Table.delegate = self
        team2Table.dataSource = self
        
        updateTeamViews();
        
        self.view.layer.insertSublayer(UIHelper.getBackgroundGradient(), atIndex: 0)
    }
    
    func updateTeamsFromOrder()
    {
        
        self.team1List = [1];
        self.team2List = [2];
        for i in 0...(playerOrder.count-1)
        {
            if i%2 == 0 // evens -> team 1 (cuz 0 indexing)
            {
                self.team1List.append(playerOrder[i])
            }
            else // odds -> team 2
            {
                self.team2List.append(playerOrder[i])
            }
        }

    }
    
    func updateTeamViews()
    {
        team1Table.reloadData();
        team2Table.reloadData();
    }
    
    @IBAction func RandomizeButtonPressed(sender: AnyObject)
    {
        playerOrder.shuffleInPlace();
        
        updateTeamsFromOrder();
        
        updateTeamViews();
    }
    
    @IBAction func FinishButtonPressed(sender: AnyObject)
    {
        //don't need anything here anymore
        performSegueWithIdentifier("QuickStartRandomizeTeamsToPlayOlympics", sender: nil)
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
            return team1List.count;
        }
        else if tableView == team2Table
        {
            return team2List.count;
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
        
        let playerNumber : Int = (tableView == team1Table ? team1List : team2List)[row];
        
        cell.textLabel?.text = "\(playerNumber)"
        
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
