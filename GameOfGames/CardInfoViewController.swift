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
    static var fromDraw:Bool = false;
    
    @IBOutlet weak var cardImage: UIImageView!
    
    @IBOutlet weak var cardNameLabel: UILabel!
    
    @IBOutlet weak var shortDescriptionLabel: UILabel!
    @IBOutlet weak var fullDescriptionLabel: UILabel!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //http://stackoverflow.com/questions/990221/multiple-lines-of-text-in-uilabel
        fullDescriptionLabel.lineBreakMode = .ByWordWrapping
        fullDescriptionLabel.numberOfLines = 0
        
        shortDescriptionLabel.lineBreakMode = .ByWordWrapping
        
        cardImage.image = UIImage(named: CardInfoViewController.currentCard.getFileName());
        cardNameLabel.text = CardInfoViewController.currentCard.toString();
        
        shortDescriptionLabel.text = CardInfoViewController.currentCard.getShortDescription();
        fullDescriptionLabel.text = CardInfoViewController.currentCard.getLongDescription();
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
    
    @IBAction func backButtonPressed(sender: AnyObject)
    {
        if CardInfoViewController.fromDraw
        {
            performSegueWithIdentifier("CardInfoToDrawCard", sender: nil)
        }
        else
        {
            performSegueWithIdentifier("CardInfoToCheckCards", sender: nil)
        }
    }
    
}
