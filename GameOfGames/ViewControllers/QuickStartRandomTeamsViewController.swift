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
  
  var shuffled : Bool = false;
  
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
    
    self.view.layer.insertSublayer(UIHelper.getBackgroundGradient(), at: 0)
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
  
  @IBAction func RandomizeButtonPressed(_ sender: AnyObject)
  {
    playerOrder.shuffle();
    updateTeamsFromOrder();
    
    updateTeamViews();
    shuffled = true;
  }
  
  @IBAction func FinishButtonPressed(_ sender: AnyObject)
  {
    if shuffled
    {
      performSegue(withIdentifier: "QuickStartRandomizeTeamsToStartOlympics", sender: nil)
    }
    else
    {
      alertToConfirm("Are you sure you want to continue without shuffling teams?",
               action:
        {
          action in self.performSegue(withIdentifier: "QuickStartRandomizeTeamsToStartOlympics", sender: nil)
      })
    }
  }
  
  func alertToConfirm(_ msg : String, action : @escaping (UIAlertAction) -> Void)
  {
    let popup = UIAlertController(title: "Alert",
                    message: msg,
                    preferredStyle: UIAlertControllerStyle.alert)
    
    let okAction = UIAlertAction(title:"OK", style: .default, handler: action);
    popup.addAction(okAction)
    
    let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
    popup.addAction(cancelAction);
    
    self.present(popup, animated: true,
                   completion: nil)
  }
  /// table view stuff ////////////////////////////////////
  
  func numberOfSections(in tableView: UITableView) -> Int
  {
    return 1;
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
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
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
  {
    let row = indexPath.row
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "TempCellView", for: indexPath) as UITableViewCell
    
    let playerNumber : Int = (tableView == team1Table ? team1List : team2List)[row];
    
    cell.textLabel?.text = "\(playerNumber)"
    
    cell.textLabel?.textColor = UIColor.white;
    cell.textLabel?.font = UIFont(name: "Lobster1.3", size: 22)
    cell.textLabel?.textAlignment = .center
    
    return cell;
  }
  
  func tableView(_ tableView: UITableView,
           didSelectRowAt indexPath: IndexPath)
  {
    //nothing when they select names
    
    //unselect this cell
    if tableView.cellForRow(at: indexPath) != nil
    {
      tableView.deselectRow(at: indexPath, animated: true)
    }
  }
  
  
  /////////////////////////////////////////////////////////////////////////////////
  
}
