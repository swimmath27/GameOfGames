//
//  NameTeamsViewController.swift
//  GameOfGames
//
//  Created by Michael Lombardo on 6/1/16.
//  Copyright © 2016 Michael Lombardo. All rights reserved.
//

import UIKit

class NameTeamsViewController: UIViewController
{

    @IBOutlet weak var askTeamNameLabel: UILabel!
    @IBOutlet weak var teamNameField: UITextField!
    
    private let game : Game = Game.getInstance();
    
    private var currentTeam : Int = 1;
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        askTeamNameLabel.text = "What is Team \(currentTeam)'s name?";
        teamNameField.text = "";
        
        teamNameField.becomeFirstResponder();
        
        self.view.layer.insertSublayer(UIHelper.getBackgroundGradient(), atIndex: 0)
    }

    override func didReceiveMemoryWarning()
    {
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
        if let s : String = teamNameField.text
        {
            if s != ""
            {
                game.setTeamName(currentTeam,name: s);
                currentTeam += 1;
                if currentTeam > 2
                {
                    // both teams have been named now
                    performSegueWithIdentifier("NameTeamsToPlayOlympics", sender: nil)
                }
                else
                {
                    askTeamNameLabel.text = "What is Team \(currentTeam)'s name?";
                    teamNameField.text = "";
                }
                return;
            }
        }
        alert("team \(currentTeam) must have a name");
        
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
