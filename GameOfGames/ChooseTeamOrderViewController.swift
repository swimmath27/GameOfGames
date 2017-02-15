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
    
    var swapPos:Int = -1;
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        tableView.delegate = self;
        tableView.dataSource = self;
        
        currentTeam = game.getCurrentTeam()
        
        currentTeamLabel.text = "Team \(currentTeam) (\(game.getTeamName(currentTeam)))"
        
        
        self.view.layer.insertSublayer(UIHelper.getBackgroundGradient(), at: 0)
    }


    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func nextButtonPressed(_ sender: AnyObject)
    {
        numTeamsDone += 1;
        if numTeamsDone > 1
        {
            // both teams have chosen their order
            performSegue(withIdentifier: "ChooseTeamOrderToPlayGame", sender: nil)
        }
        else
        {
            //the other team must choose their order
            currentTeam = (currentTeam==1 ? 2 : 1);
            
            currentTeamLabel.text = "Team \(currentTeam) (\(game.getTeamName(currentTeam)))"
            tableView.reloadData();
            
            //when we go to the other team, we gotta reset the swaps
            swapPos = -1;
        }
    }
    
    
    /// table view stuff ////////////////////////////////////
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        
        return game.getTeam(currentTeam).count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let row = indexPath.row
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TempCellView", for: indexPath) as UITableViewCell
        
        let playerNumber : Int = game.getTeam(currentTeam)[row];
        
        cell.textLabel?.text = game.getPlayerName(playerNumber)
        
        cell.textLabel?.textColor = UIColor.white;
        cell.textLabel?.font = UIFont(name: "Lobster1.3", size: 22)
        cell.textLabel?.textAlignment = .center
        
        return cell;
        
    }
    
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath)
    {
        //unselect this cell
        if tableView.cellForRow(at: indexPath) != nil
        {
            tableView.deselectRow(at: indexPath, animated: false)
        }
        
        let row = indexPath.row
        if row == 0
        {
            alert("Team Captain must always be first");
        }
        else if (swapPos == -1) // this is the first selection
        {
            swapPos = row;
            if let cell = tableView.cellForRow(at: indexPath)
            {
                cell.backgroundColor = UIColor.red
            }
        }
        else // this is the second selection
        {
            if (swapPos != row)
            {
                game.swapPlayersInTeam(swapPos, player2: row, team: currentTeam);
            }
            if let cell = tableView.cellForRow(at: IndexPath(row: swapPos, section: 0))
            {
                cell.backgroundColor = UIColor.clear;
            }
            
            //game.sendPlayerToEndOfTeam(row,team:currentTeam)
            tableView.reloadData()
            swapPos = -1
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
    
}
