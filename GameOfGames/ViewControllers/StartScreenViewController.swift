//
//  StartScreenViewController.swift
//  GameOfGames
//
//  Created by Michael Lombardo on 6/1/16.
//  Copyright © 2016 Michael Lombardo. All rights reserved.
//

import UIKit

class StartScreenViewController: UIViewController {

  //this is so it loads the deck stuff as soon as the app loads
  let game:Game = Game.getInstance();
  
  @IBOutlet weak var rulebookButton: UIButton!
  @IBOutlet weak var cardsButton: UIButton!
  @IBOutlet weak var playButton: UIButton!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    //maybe have an activity indicator here to let them know that its still loading
    //the problem with that is that i can't figure a way to tell the deck
    //how to stop the activity indicator animation
    //because theres no way to get a method into the deck constructor
    
    //maybe have a public static variable that we set to the local one?
    
//    for familyName in UIFont.familyNames() {
//      print("\n-- \(familyName) \n")
//      for fontName in UIFont.fontNamesForFamilyName(familyName) {
//        print(fontName)
//      }
//    }
    
    self.view.layer.insertSublayer(UIHelper.getBackgroundGradient(), at: 0)
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  @IBAction func cardsButtonPressed(_ sender: AnyObject) {
    if (game.readyToGo) {
      performSegue(withIdentifier: "StartScreenToWholeDeck", sender: nil)
    }
    else {
      alert("Alert", msg: "The game is still loading necessary files, please wait")
    }

  }

  @IBAction func playButtonPressed(_ sender: AnyObject) {
    // uhhhh im not sure how to do thread compliant stuff -> it could be ready and not notice yet?
    if (game.readyToGo) {
      performSegue(withIdentifier: "StartScreenToNumPlayers", sender: nil)
    }
    else {
      alert("Alert", msg: "The game is still loading necessary files, please wait")
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
  
  @IBAction func rulebookButtonPressed(_ sender: AnyObject) {
    if let url = URL(string: Game.RULEBOOK_URL) {
      UIApplication.shared.openURL(url)
    }
  }
  
  
  func alert(_ title: String, msg : String) {
    let popup = UIAlertController(title: title,
                    message: msg,
                    preferredStyle: UIAlertControllerStyle.alert)
    
    let cancelAction = UIAlertAction(title: "OK",
                     style: .cancel, handler: nil)
    
    popup.addAction(cancelAction)
    self.present(popup, animated: true,
                   completion: nil)
    
  }

}
