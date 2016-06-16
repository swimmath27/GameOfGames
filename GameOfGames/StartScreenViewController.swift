//
//  StartScreenViewController.swift
//  GameOfGames
//
//  Created by Michael Lombardo on 6/1/16.
//  Copyright © 2016 Michael Lombardo. All rights reserved.
//

import UIKit

class StartScreenViewController: UIViewController
{

    //this is so it loads the deck stuff as soon as the app loads
    let game:Game = Game.getInstance();
    
    @IBOutlet weak var rulebookButton: UIButton!
    @IBOutlet weak var cardsButton: UIButton!
    @IBOutlet weak var playButton: UIButton!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
//        for familyName in UIFont.familyNames() {
//            print("\n-- \(familyName) \n")
//            for fontName in UIFont.fontNamesForFamilyName(familyName) {
//                print(fontName)
//            }
//        }
        
        
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

    @IBAction func rulebookButtonPressed(sender: AnyObject)
    {
        if let url = NSURL(string: Game.RULEBOOK_URL)
        {
            UIApplication.sharedApplication().openURL(url)
        }
    }
}
