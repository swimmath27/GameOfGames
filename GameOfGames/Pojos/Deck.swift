//
//  Deck.swift
//  GameOfGames
//
//  Created by Michael Lombardo on 5/31/16.
//  Copyright © 2016 Michael Lombardo. All rights reserved.
//

import Foundation
import CSwiftV

class Deck
{
  //old one with no headers
  //private static let CARDS_URL:String = "http://nathanand.co/wp-content/uploads/2016/06/Game-of-Games-Cards.csv"
  
  //new one with headers and a 5th column, "Playable"
  fileprivate static let CARDS_URL:String = "http://nathanand.co/wp-content/uploads/2016/06/Game-of-Games-Cards-1.csv"
  
  fileprivate static let CARDS_DEFAULT_NAME:String = "Game-of-Games-Cards-Default.csv"
  fileprivate static let CARDS_DOWNLOAD_NAME:String = "Game-of-Games-Cards.csv"
  
  fileprivate(set) var deck = [Card]()
  fileprivate var order:[Int] = [Int]()
  fileprivate var index:Int = 0
  
  init()
  {
    //print(Deck.CARDS_URL);
    
    HttpDownloader.loadFileAsync(URL(string: Deck.CARDS_URL)!,
      completion:
      { (path, error) -> Void in
        if error == nil
        {
          self.loadCards(path);
        }
        else
        {
          //if there was an error, ignore it and load the default cards
          print("error getting cards url, ignoring and loading defaults");
          let bundleURL = Bundle.main.bundleURL
          let fileURL = bundleURL.appendingPathComponent(Deck.CARDS_DEFAULT_NAME)
          
          self.loadCards(fileURL.path);
        }
        self.shuffle();
        Game.instance.readyToGo = true;
      })
  }
  
  fileprivate func loadCards(_ path:String)
  {
    // because this is happening from another thread, might as well lock it
    objc_sync_enter(deck)
    deck = parseCSV(path, encoding: String.Encoding.utf8, error: nil)
    objc_sync_exit(deck)
  }
  
  //adapted from
  //http://stackoverflow.com/questions/32313938/parsing-csv-file-in-swift
  //edit: that one sucked (like a lot) so i'm using CSwiftV now
  fileprivate func parseCSV (_ contentsOfFile: String, encoding: String.Encoding, error: NSErrorPointer) -> [Card] {
    
    var mindCount:Int = 0;
    var bodyCount:Int = 0;
    var soulCount:Int = 0;
    var chanceCount:Int = 0;
    
    var ret:[Card] = [Card]()
    
    print("loading \"\(contentsOfFile)\"")
    
    if let data = try? Data(contentsOf: URL(fileURLWithPath: contentsOfFile))
    {
      if let content = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
      {
      
        //its being mean when i leave out separator, but the default is "," so i put that in
        // the header is left out of the file because it was causing problems before with the stupid parser
        //let csv = CSwiftV(string: content.description, separator: ",", headers: ["Type","Name","Stealable","Description"]);
        
        //update: header is back in
        let csv = CSwiftV(string: content.description);
        
        let headers = csv.headers;
        
        if (!headers.contains("Type") || !headers.contains("Title") || !headers.contains("Stealable") || !headers.contains("Playable") || !headers.contains("Description"))
        {
          print("error, file doesn't have correct headers, using default")
          
          let bundleURL = Bundle.main.bundleURL
          let fileURL = bundleURL.appendingPathComponent(Deck.CARDS_DEFAULT_NAME)
          
          return self.parseCSV(fileURL.path, encoding: String.Encoding.utf8, error: nil);
        }
        
        //print(csv.headers);
        for row in csv.keyedRows!
        {
          var suit:Card.Suit = Card.Suit.joke;
          var rank:Int = 0;
          switch row["Type"]!
          {
          case "M":
            mindCount+=1
            rank = mindCount;
            suit = Card.Suit.mind;
          case "S":
            soulCount+=1
            rank = soulCount;
            suit = Card.Suit.soul;
          case "C":
            chanceCount+=1
            rank = chanceCount
            suit = Card.Suit.chance;
          case "B":
            bodyCount+=1
            rank = bodyCount
            suit = Card.Suit.body;
          default:break
          }
          
          let stealable:Bool = row["Stealable"] == "Y";
          let playable:Bool = row["Playable"] == "Y";
          
          ret.append(Card(suit: suit, rank: rank, stealable: stealable, playable: playable, shortDescription: row["Title"]!, longDescription: row["Description"]!))
          //print(row[1]);
          
          //type - values[0]
          //name - values[1]
          //stealable - values[2]
          //description - values[3]
          
        }
      }
    }
    return ret;
  }
  
  func shuffle()
  {
    print("shuffling");
    if (order.count != deck.count)
    {
      for i in 0...(deck.count-1)
      {
        order.append(i);
      }
    }
    order.shuffle()
  }
  
  func hasNextCard() -> Bool
  {
    return index < deck.count;
  }
  
  func nextCard() -> Card
  {
    if self.hasNextCard()
    {
      index += 1;
    }
    return deck[order[index-1]];
  }
  
  func undrawCard()
  {
    //taken from the extension where we shuffle. Shuffle one card back into the deck
    let j = Int(arc4random_uniform(UInt32(order.count - index))) + index
    guard index != j else { return }
    swap(&order[index], &order[j])
    
    index -= 1 // go back one index
  }
  
  

}
