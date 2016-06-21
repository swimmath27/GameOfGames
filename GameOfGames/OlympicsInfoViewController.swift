//
//  OlympicsInfoViewController.swift
//  GameOfGames
//
//  Created by Michael Lombardo on 6/21/16.
//  Copyright © 2016 Michael Lombardo. All rights reserved.
//

import UIKit

class OlympicsInfoViewController: UIViewController
{

    @IBOutlet weak var infoTextView: UITextView!
    
    let game:Game = Game.getInstance()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let path = NSBundle.mainBundle().pathForResource("GoGOlympicsRules", ofType: "txt");
        
        do
        {
            infoTextView.text = try NSString(contentsOfURL: NSURL(fileURLWithPath: path!), encoding: NSUTF8StringEncoding) as String
        }
        catch {}
        
        //i'm not sure why i need to put this here, but it doesn't work if its on the storyboard
        infoTextView.font = UIFont(name: "JosefinSans", size: 20)
        infoTextView.textColor = UIColor.whiteColor();
        
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