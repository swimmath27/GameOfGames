//
//  CheckCardsViewController.swift
//  GameOfGames
//
//  Created by Michael Lombardo on 6/1/16.
//  Copyright © 2016 Michael Lombardo. All rights reserved.
//

import UIKit

class CheckCardsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    static var whichTeam = 1;
    
    @IBOutlet weak var teamNameLabel: UILabel!
    @IBOutlet weak var cardsTable: UITableView!
    
    let game : Game = Game.getInstance();
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        cardsTable.delegate = self
        cardsTable.dataSource = self
        
        teamNameLabel.text = "\(game.getTeamName(CheckCardsViewController.whichTeam))'s Cards"

        
        self.view.layer.insertSublayer(UIHelper.getBackgroundGradient(), atIndex: 0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    /// table view stuff ////////////////////////////////////
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1;
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return game.getTeamCards(CheckCardsViewController.whichTeam).count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let row = indexPath.row
        
        let cell = tableView.dequeueReusableCellWithIdentifier("TempCellView", forIndexPath: indexPath) as UITableViewCell
        
        let card : Card = game.getTeamCards(CheckCardsViewController.whichTeam)[row]
        
        cell.textLabel?.text = card.shortDesc;
        
        cell.textLabel?.textColor = UIColor.whiteColor();
        cell.textLabel?.font = UIFont(name: "Lobster1.3", size: 22)
        cell.textLabel?.textAlignment = .Center
        
        return cell;
    }
    
    func tableView(tableView: UITableView,
                   didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        //unselect this cell
        if tableView.cellForRowAtIndexPath(indexPath) != nil
        {
            tableView.deselectRowAtIndexPath(indexPath, animated: false)
        }
        
        let row = indexPath.row
        
        CardInfoViewController.currentCard = game.getTeamCards(CheckCardsViewController.whichTeam)[row]
        CardInfoViewController.from = "CheckCards";
        
       
        
        performSegueWithIdentifier("CheckCardsToCardInfo", sender: nil)
        
    }
    
    
    /////////////////////////////////////////////////////////////////////////////////

}
