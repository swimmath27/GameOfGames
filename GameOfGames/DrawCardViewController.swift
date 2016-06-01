//
//  DrawCardViewController.swift
//  GameOfGames
//
//  Created by Michael Lombardo on 5/31/16.
//  Copyright © 2016 Michael Lombardo. All rights reserved.
//

import UIKit

class DrawCardViewController: UIViewController {

    @IBOutlet weak var playerIntroductionLabel: UILabel!
    @IBOutlet weak var whichCardLabel: UILabel!
    
    private var game:Game = Game.getInstance();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        playerIntroductionLabel.text = "Player \(game.getCurrentPlayer()), Your Card is..."
 
        whichCardLabel.text = game.drawCard();
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func WonButtonPressed(sender: AnyObject)
    {
        game.cardWasWon();
        
        performSegueWithIdentifier("DrawCardToPlayGame", sender: nil)
    }

    @IBAction func LostButtonPressed(sender: AnyObject)
    {
        game.cardWasLost();
        
        performSegueWithIdentifier("DrawCardToPlayGame", sender: nil)
    }
    
    @IBAction func StolenButtonPressed(sender: AnyObject)
    {
        game.cardWasStolen();
        
        performSegueWithIdentifier("DrawCardToPlayGame", sender: nil)
    }
    
    @IBAction func rulebookButtonPressed(sender: AnyObject) {
        if let url = NSURL(string: "http://nathanand.co/wp-content/uploads/2016/05/The-Game-of-Games-Rulebook.pdf"){
            UIApplication.sharedApplication().openURL(url)
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
     */
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
