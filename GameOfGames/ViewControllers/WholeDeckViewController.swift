//
//  WholeDeckViewController.swift
//  GameOfGames
//
//  Created by Michael Lombardo on 6/6/16.
//  Copyright © 2016 Michael Lombardo. All rights reserved.
//

import UIKit

class WholeDeckViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate
{
  
  @IBOutlet weak var imageCollectionView: UICollectionView!
  let reuseIdentifier = "ImageCollectionViewCell";
  
  let game : Game = Game.getInstance();
  
  override func viewDidLoad()
  {
    super.viewDidLoad()
    
    imageCollectionView.delegate = self;
    imageCollectionView.dataSource = self;
    
    imageCollectionView.backgroundColor = UIColor.clear;
    
    imageCollectionView.reloadData();
    
    
    
    // http://stackoverflow.com/questions/13360975/uicollectionviews-cell-disappearing Yao's answer
    // dont even ask
    // nevermind DONT EVEN LOOK HERE
    // THIS CODE DOESNT EXIST
    imageCollectionView.reloadSections(IndexSet(integer: 0))
    imageCollectionView.reloadSections(IndexSet(integer: 0))
    imageCollectionView.reloadSections(IndexSet(integer: 0))
    imageCollectionView.reloadSections(IndexSet(integer: 0))
    imageCollectionView.reloadSections(IndexSet(integer: 0))
    imageCollectionView.reloadSections(IndexSet(integer: 0))
    imageCollectionView.reloadSections(IndexSet(integer: 0))
    imageCollectionView.reloadSections(IndexSet(integer: 0))
    // FORGET YOU SAW ANYTHING
    // ...
    // i mean it
    
    // each call to that function fixes 2 of them at a time and there are 
    // 12 of them messed up
    // ...
    // no there is no reason why this happens
    
    //edit: there are like 15 messed up now
    
    self.view.layer.insertSublayer(UIHelper.getBackgroundGradient(), at: 0)
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
  
  
  /////////////Collection View stuff //////////////////
  
  // tell the collection view how many cells to make
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
  {
    return game.getOrderedCards().count
  }
  
  // make a cell for each cell index path
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
  {
   
    let row:Int = indexPath.row
    let card:Card = game.getOrderedCards()[row];
    
    // get a reference to our storyboard cell
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ImageCollectionViewCell

    // Use the outlet in our custom class to get a reference to the UIImageView in the cell
    cell.imageView.image = UIImage(named: card.getFileName())
    cell.imageView.contentMode = .scaleAspectFill;
    cell.imageView.clipsToBounds = true;
    
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    // handle tap events
    let row:Int = indexPath.row
    
    CardInfoViewController.currentCard = game.getOrderedCards()[row]
    CardInfoViewController.from = "WholeDeck"
    
    performSegue(withIdentifier: "WholeDeckToCardInfo", sender: nil)
    
  }
  
  //////////////////////////////////////////////////////////
}
