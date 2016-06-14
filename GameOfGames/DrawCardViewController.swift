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
    @IBOutlet weak var youDrewLabel: UILabel!
    
    @IBOutlet weak var cardImageButton: UIButton!

    @IBOutlet weak var whichCardLabel: UILabel!
    
    @IBOutlet weak var skipButton: UIButton!
    @IBOutlet weak var wonButton: UIButton!
    @IBOutlet weak var lostButton: UIButton!
    @IBOutlet weak var stolenButton: UIButton!
    
    private var game:Game = Game.getInstance();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        playerIntroductionLabel.text = "\(game.getCurrentPlayerName()),"
        
        self.loadCurrentCard();
        
        //TODO: check if losable and hide the lose button as well
        
        //background gradient
        self.view.layer.insertSublayer(UIHelper.getBackgroundGradient(), atIndex: 0)
    }

    func loadCurrentCard()
    {
        
        whichCardLabel.text = "\(game.getCurrentCard()!.getShortDescription())!";
        
        let cardPic: UIImage? = UIImage(named: game.getCurrentCard()!.getFileName())
        if cardPic != nil
        {
            cardImageButton.setImage(cardPic, forState: .Normal)
            
            cardImageButton.imageEdgeInsets = UIEdgeInsetsMake(0,0,0,0)
        }
        else
        {
            cardImageButton.setTitle(game.getCurrentCard()!.toString(), forState: .Normal)
        }
        
        
        if game.getCurrentCard()!.isStealable()
        {
            stolenButton.hidden = false
        }
        else
        {
            stolenButton.hidden = true
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cardInfoButtonPressed(sender: AnyObject)
    {
        
        CardInfoViewController.currentCard = game.getCurrentCard()!;
        CardInfoViewController.from = "DrawCard";
        performSegueWithIdentifier("DrawCardToCardInfo", sender: nil)
    }
    
    @IBAction func WonButtonPressed(sender: AnyObject)
    {
//        let drink:String = game.getCurrentCard()!.getDrink();
        
        //alertAndGoBack("Congratz", s:"Please add \(drink) into the cup and send \(drink) to any player on the other team", whichAction: "won")
        self.goToNext("won");
       
    }

    @IBAction func LostButtonPressed(sender: AnyObject)
    {
//        let drink:String = game.getCurrentCard()!.getDrink();
        
        //alertAndGoBack("Too bad", s:"Please drink \(drink) and give \(drink) to a team member",whichAction: "lost")
        self.goToNext("lost");
    }
    
    @IBAction func StolenButtonPressed(sender: AnyObject)
    {
//        let drink:String = game.getCurrentCard()!.getDrink();
        
        //alertAndGoBack("...", s:"Please add \(drink) into the cup and the other team sends \(drink) to any player on your team", whichAction: "stolen")
        self.goToNext("stolen");
    }
    
    @IBAction func skipCardButtonPressed(sender: AnyObject)
    {
        alertAndGoBack("Alert", s:"Card will be skipped. Make sure both team captains agree as this cannot be undone",whichAction: "skipped")
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
     */
    
    func goToNext(whichAction:String)
    {
        switch whichAction
        {
        case "won":
            game.cardWasWon();
        case "lost":
            game.cardWasLost();
        case "stolen":
            game.cardWasStolen();
        case "skipped":
            game.drawCard();
            self.loadCurrentCard();
            return; // stay here if skipped
        default: break
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
    
    func alertAndGoBack(t:String, s : String, whichAction:String)
    {
        let popup = UIAlertController(title: t,
                                      message: s,
                                      preferredStyle: UIAlertControllerStyle.Alert)
        
        let okAction = UIAlertAction(title:"OK", style: .Default, handler:
                                    {
                                        action in self.goToNext(whichAction)
                                    })
        popup.addAction(okAction)
        
        
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .Cancel, handler: nil)
        popup.addAction(cancelAction);
        
        self.presentViewController(popup, animated: true,
                                   completion: nil)
        
    }


}
