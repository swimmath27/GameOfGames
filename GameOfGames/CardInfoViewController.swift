//
//  CardInfoViewController.swift
//  GameOfGames
//
//  Created by Michael Lombardo on 6/3/16.
//  Copyright © 2016 Michael Lombardo. All rights reserved.
//

import UIKit

class CardInfoViewController: UIViewController
{
    static var currentCard:Card = Card(suit: Card.Suit.Joke, rank: 0);
    
    //whether or not this was initialized from draw card view controller
    //if true -> go back to draw card view controller
    //if false -> go back to check cards view controller
    static var from:String = "";
    
    @IBOutlet weak var cardNameLabel: UILabel!
    
    @IBOutlet weak var fullDescriptionLabel: UILabel!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //http://stackoverflow.com/questions/990221/multiple-lines-of-text-in-uilabel
//        fullDescriptionLabel.lineBreakMode = .ByWordWrapping
//        fullDescriptionLabel.numberOfLines = 0
        //i did the above in the storyboard but leaving it here for reference
        
        cardNameLabel.lineBreakMode = .ByWordWrapping
        
        cardNameLabel.text = CardInfoViewController.currentCard.getShortDescription();
        
        fullDescriptionLabel.text = CardInfoViewController.currentCard.getLongDescription();
        
        self.view.layer.insertSublayer(UIHelper.getBackgroundGradient(), atIndex: 0)
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?)
    {
        backButtonPressed(self);
    }

    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    @IBAction func backButtonPressed(sender: AnyObject)
    {
        
        let segueID:String = "CardInfoTo"+CardInfoViewController.from; // back to where we came from
        
        performSegueWithIdentifier(segueID, sender: nil)
       
    }
    
}
