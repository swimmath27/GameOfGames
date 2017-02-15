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
    static var currentCard:Card = Card(suit: Card.Suit.joke, rank: 0);
    
    //whether or not this was initialized from draw card view controller
    //if true -> go back to draw card view controller
    //if false -> go back to check cards view controller
    static var from:String = "";
    
    @IBOutlet weak var cardNameLabel: UILabel!
    
    @IBOutlet weak var fullDescriptionLabel: UILabel!
    
    @IBOutlet weak var cardSuitLabel: UILabel!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //http://stackoverflow.com/questions/990221/multiple-lines-of-text-in-uilabel
//        fullDescriptionLabel.lineBreakMode = .ByWordWrapping
//        fullDescriptionLabel.numberOfLines = 0
        //i did the above in the storyboard but leaving it here for reference
        
        cardNameLabel.lineBreakMode = .byWordWrapping
        
        cardNameLabel.text = CardInfoViewController.currentCard.shortDesc
        
        cardSuitLabel.text = CardInfoViewController.currentCard.suit.simpleDescription();
        
        fullDescriptionLabel.text = CardInfoViewController.currentCard.longDesc;
        
        self.view.layer.insertSublayer(UIHelper.getBackgroundGradient(), at: 0)
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
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
    
    @IBAction func backButtonPressed(_ sender: AnyObject)
    {
        
        let segueID:String = "CardInfoTo"+CardInfoViewController.from; // back to where we came from
        
        performSegue(withIdentifier: segueID, sender: nil)
       
    }
    
}
