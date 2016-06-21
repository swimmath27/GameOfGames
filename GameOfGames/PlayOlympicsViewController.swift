//
//  PlayOlympicsViewController.swift
//  GameOfGames
//
//  Created by Michael Lombardo on 6/1/16.
//  Copyright © 2016 Michael Lombardo. All rights reserved.
//

import UIKit

class PlayOlympicsViewController: UIViewController {

    @IBOutlet weak var game1Segment: UISegmentedControl!
    @IBOutlet weak var game2Segment: UISegmentedControl!
    @IBOutlet weak var game3Segment: UISegmentedControl!
    
    private let game : Game = Game.getInstance();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.

        game1Segment.selectedSegmentIndex = 1;
        game2Segment.selectedSegmentIndex = 1;
        game3Segment.selectedSegmentIndex = 1;
        
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

    @IBAction func submitButtonPressed(sender: AnyObject)
    {
        var team1Wins : Int = 0;
        var team2Wins : Int = 0;
        
        //team 1 is index 0
        team1Wins += game1Segment.selectedSegmentIndex == 0 ? 1 : 0;
        team1Wins += game2Segment.selectedSegmentIndex == 0 ? 1 : 0;
        team1Wins += game3Segment.selectedSegmentIndex == 0 ? 1 : 0;
        
        //team 2 is index 2
        team2Wins += game1Segment.selectedSegmentIndex == 2 ? 1 : 0;
        team2Wins += game2Segment.selectedSegmentIndex == 2 ? 1 : 0;
        team2Wins += game3Segment.selectedSegmentIndex == 2 ? 1 : 0;
        
        //ties are index 1 but we don't care about them
        if team1Wins == team2Wins
        {
            alert("There is no clear winner (if teams did tie: \"rock, paper, scissors, shoot\" for who goes first)");
            return;
        }
        else if (team2Wins > team1Wins)
        {
            game.setTeamGoingFirst(2);
        }
        //team 1 is automatically set to go first so we don't have to update it
        
        performSegueWithIdentifier("PlayOlympicsToEndOlympics", sender: nil)
        
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
