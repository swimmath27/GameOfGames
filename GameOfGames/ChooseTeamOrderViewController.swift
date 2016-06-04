//
//  ChooseTeamOrderViewController.swift
//  GameOfGames
//
//  Created by Michael Lombardo on 6/4/16.
//  Copyright © 2016 Michael Lombardo. All rights reserved.
//

import UIKit

class ChooseTeamOrderViewController: UIViewController, UITableViewDataSource, UITableViewDelegate
{

    
    @IBOutlet weak var currentTeamLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    let game : Game = Game.getInstance()
    
    var currentTeam = 0;
    var numTeamsDone = 0;
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        tableView.delegate = self;
        tableView.dataSource = self;
        
        currentTeam = game.getCurrentTeam()
        
        currentTeamLabel.text = "Team \(currentTeam) (\(game.getTeamName(currentTeam)))"
    }


    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func nextButtonPressed(sender: AnyObject)
    {
        numTeamsDone += 1;
        if numTeamsDone > 1
        {
            // both teams have chosen their order
            performSegueWithIdentifier("ChooseTeamOrderToPlayGame", sender: nil)
        }
        else
        {
            //the other team must choose their order
            currentTeam = (currentTeam==1 ? 2 : 1);
            
            currentTeamLabel.text = "Team \(currentTeam) (\(game.getTeamName(currentTeam)))"
            tableView.reloadData();
        }
    }
    
    
    /// table view stuff ////////////////////////////////////
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1;
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        
        return game.getTeam(currentTeam).count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let row = indexPath.row
        
        let cell = tableView.dequeueReusableCellWithIdentifier("TempCellView", forIndexPath: indexPath) as UITableViewCell
        
        let playerNumber : Int = game.getTeam(currentTeam)[row];
        
        cell.textLabel?.text = game.getPlayerName(playerNumber)
        
        return cell;
        
    }
    
    func tableView(tableView: UITableView,
                   didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        //nothing when they select cards
        
        let row = indexPath.row
        if row == 0
        {
            alert("Team Captain must always be first");
        }
        else
        {
            game.sendPlayerToEndOfTeam(row,team:currentTeam)
            tableView.reloadData()
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
