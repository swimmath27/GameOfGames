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
        
        playerIntroductionLabel.text = game.getCurrentPlayerName() + ", Your Card is..."
 
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
        let drink:String = game.getCurrentCard()!.getDrink();
        // add one unit of the corresponding drink into the Bitch Cup and sends one unit of the drink to any player on the other team
        alertAndGoBack("Congratz", s:"Please add one \(drink) into the cup and send one \(drink) to any player on the other team")
        
        //performSegueWithIdentifier("DrawCardToPlayGame", sender: nil)
    }

    @IBAction func LostButtonPressed(sender: AnyObject)
    {
        // If a team fails to collect the card, the drawer of the card, as well as a team member of his or her choosing, has to drink a unit of the corresponding drink.
        let drink:String = game.getCurrentCard()!.getDrink();
        
        alertAndGoBack("Too bad", s:"Please drink one \(drink) and give one \(drink) to a team member",whichAction: 1)
        
        //performSegueWithIdentifier("DrawCardToPlayGame", sender: nil)
    }
    
    @IBAction func StolenButtonPressed(sender: AnyObject)
    {
        
        
        let drink:String = game.getCurrentCard()!.getDrink();
        
        alertAndGoBack("...", s:"Please add one \(drink) into the cup and the other team sends one \(drink) to any player on your team", whichAction: 2)

        //performSegueWithIdentifier("DrawCardToPlayGame", sender: nil)
    }
    
    @IBAction func skipCardButtonPressed(sender: AnyObject)
    {
        
        alertAndGoBack("Alert", s:"Card will be skipped and your turn will continue (This cannot be undone)",whichAction: 3)
        
        //performSegueWithIdentifier("DrawCardToPlayGame", sender: nil)
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
    
    func goToNext(whichAction:Int)
    {
        switch whichAction
        {
        case 1:
            game.cardWasLost();
        case 2:
            game.cardWasStolen();
        case 3:
            game.cardWasSkipped();
            
        }
        if game.isNewRound()
        {
            self.performSegueWithIdentifier(
                "DrawCardToRoundRoulette", sender: self)
        }
        else
        {
            self.performSegueWithIdentifier(
                "DrawCardToPlayGame", sender: self)
        }
    }
    
    func alertAndGoBack(t:String, s : String, whichAction:Int)
    {
        let popup = UIAlertController(title: t,
                                      message: s,
                                      preferredStyle: UIAlertControllerStyle.Alert)
        
        let okAction = UIAlertAction(title:"OK", style: .Default, handler:
                                    {
                                        action in self.goToNext(which)
                                    })
        popup.addAction(okAction)
        
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .Cancel, handler: nil)
        popup.addAction(cancelAction);
        
        self.presentViewController(popup, animated: true,
                                   completion: nil)
        
    }


}
