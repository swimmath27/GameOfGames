//
//  RoundRouletteViewController.swift
//  GameOfGames
//
//  Created by Michael Lombardo on 6/1/16.
//  Copyright © 2016 Michael Lombardo. All rights reserved.
//

import UIKit

class RoundRouletteViewController: UIViewController {

    @IBOutlet weak var team1Name: UILabel!
    @IBOutlet weak var team2Name: UILabel!
    
    @IBOutlet weak var team1Chance: UILabel!
    @IBOutlet weak var team2Chance: UILabel!
    
    let game : Game = Game.getInstance()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        team1Name.text = "\(game.getTeamName(1))'s Chance"
        team2Name.text = "\(game.getTeamName(2))'s Chance"
        
        //chance that team 1 drinks is proportional to the number of cards team 2 got
        //need the last round version because current it is the next round
        team1Chance.text = "\(game.getTeamCardsInLastRound(2))/\(game.getCardsWonInLastRound())"
        team2Chance.text = "\(game.getTeamCardsInLastRound(1))/\(game.getCardsWonInLastRound())"
        
        // Do any additional setup after loading the view.
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

}
