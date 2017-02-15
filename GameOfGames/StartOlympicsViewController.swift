//
//  StartOlympicsViewController.swift
//  GameOfGames
//
//  Created by Michael Lombardo on 6/21/16.
//  Copyright © 2016 Michael Lombardo. All rights reserved.
//

import UIKit

class StartOlympicsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.layer.insertSublayer(UIHelper.getBackgroundGradient(), at: 0)
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
