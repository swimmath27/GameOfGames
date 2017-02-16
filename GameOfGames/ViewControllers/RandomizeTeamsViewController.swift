//
//  RandomizeTeamsViewController.swift
//  GameOfGames
//
//  Created by Michael Lombardo on 5/31/16.
//  Copyright © 2016 Michael Lombardo. All rights reserved.
//

import UIKit

class RandomizeTeamsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
  @IBOutlet weak var team1Table: UITableView!
  @IBOutlet weak var team2Table: UITableView!
  
  var game:Game = Game.getInstance();
  
  var shuffled:Bool = false;
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    team1Table.delegate = self
    team1Table.dataSource = self
    
    team2Table.delegate = self
    team2Table.dataSource = self
    
    updateTeamViews();
    
    self.view.layer.insertSublayer(UIHelper.getBackgroundGradient(), at: 0)
  }

  func updateTeamViews() {
    team1Table.reloadData();
    team2Table.reloadData();
  }
  
  @IBAction func RandomizeButtonPressed(_ sender: AnyObject) {
    game.shuffleTeams();
    updateTeamViews();
    shuffled = true;
  }
  
  @IBAction func FinishButtonPressed(_ sender: AnyObject) {
    if shuffled {
      performSegue(withIdentifier: "RandomizeTeamsToNameTeams", sender: nil)
    }
    else {
      alertToConfirm("Are you sure you want to continue without shuffling teams?",
               action: {
                action in self.performSegue(withIdentifier: "RandomizeTeamsToNameTeams", sender: nil)
               })
    }
  }
  
  func alertToConfirm(_ msg : String, action : @escaping (UIAlertAction) -> Void) {
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
  
  ///////////////////////////// table view stuff ////////////////////////////////////
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1;
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if tableView == team1Table {
      return game.getTeam(1).count;
    }
    else if tableView == team2Table {
      return game.getTeam(2).count;
    }
    else {
      return 0;
    }
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let row = indexPath.row
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "TempCellView", for: indexPath) as UITableViewCell
    
    let playerNumber: Int = game.getTeam(tableView == team1Table ? 1 : 2)[row];
    
    cell.textLabel?.text = game.getPlayerName(playerNumber)
      
    cell.textLabel?.textColor = UIColor.white;
    cell.textLabel?.font = UIFont(name: "Lobster1.3", size: 22)
    cell.textLabel?.textAlignment = .center
    
    return cell;
  }
  
  func tableView(_ tableView: UITableView,
           didSelectRowAt indexPath: IndexPath) {
    //nothing when they select names
    
    //unselect this cell
    if tableView.cellForRow(at: indexPath) != nil {
      tableView.deselectRow(at: indexPath, animated: true)
    }
  }
  
  
  /////////////////////////////////////////////////////////////////////////////////

}
