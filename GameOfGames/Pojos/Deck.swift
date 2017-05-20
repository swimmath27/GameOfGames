//
//  Deck.swift
//  GameOfGames
//
//  Created by Michael Lombardo on 5/31/16.
//  Copyright © 2016 Michael Lombardo. All rights reserved.
//

import Foundation
import CSwiftV

import Firebase
import FirebaseDatabase

class Deck {
  //old one with no headers
  //private static let CARDS_URL:String = "http://nathanand.co/wp-content/uploads/2016/06/Game-of-Games-Cards.csv"

  fileprivate(set) static var singleton: Deck = Deck();

  //new one with headers and a 5th column, "Playable"
  fileprivate static let CARDS_URL:String = "http://nathanand.co/wp-content/uploads/2016/06/Game-of-Games-Cards-1.csv"

  fileprivate static let CARDS_DEFAULT_NAME:String = "Game-of-Games-Cards-Default.csv"
  fileprivate static let CARDS_DOWNLOAD_NAME:String = "Game-of-Games-Cards.csv"

  fileprivate(set) var deck = [Card]()
  fileprivate var order:[Int] = [Int]()
  fileprivate var index:Int = 0

  fileprivate var ref: DatabaseReference!

  init() {
    // used to load the deck here, but firebase isn't loaded yet by the time this runs. Hence the load function below.
  }

  func load() {
    self.getCardsFromFirebase();
    //self.getCardsFromWebsite();
  }

  fileprivate func getCardsFromFirebase(){
    self.ref = Database.database().reference();
    // load once - don't bother updating during the game.
    self.ref.child("Cards").observeSingleEvent(of: .value, with: { (snapshot) in
      self.loadCardsFIR(snapshot: snapshot);
      self.shuffle();
      Game.instance.readyToGo = true;
    }) { (error) in
      print(error.localizedDescription)
    }
  }

  fileprivate func loadCardsFIR(snapshot: DataSnapshot) {
    objc_sync_enter(deck)

    var headCount:Int = 0;
    var muscleCount:Int = 0;
    var moxieCount:Int = 0;
    var randomCount:Int = 0;

    let cards = snapshot.value as! NSArray
    print("============================");
    print(cards)
    for item in cards {
      if let card = item as? NSDictionary {
        print("============================");
        print(card);
        print("============================");
        var suit:Card.Suit = Card.Suit.joke;
        var rank:Int = 0;
        switch card["Type"] as! String {
        case "head":
          headCount+=1
          rank = headCount;
          suit = Card.Suit.head;
        case "moxie":
          moxieCount+=1
          rank = moxieCount;
          suit = Card.Suit.moxie;
        case "random":
          randomCount+=1
          rank = randomCount
          suit = Card.Suit.random;
        case "muscle":
          muscleCount+=1
          rank = muscleCount
          suit = Card.Suit.muscle;
        default:break
        }

        let stealable:Bool = (card["Stealable"] as! String) == "Y";
        let playable:Bool = (card["Playable"] as! String) == "Y";

        self.deck.append(Card(suit: suit, rank: rank, stealable: stealable, playable: playable, shortDescription: card["Title"] as! String, longDescription: card["Description"] as! String))
      }
    }
    objc_sync_exit(deck)
  }

  fileprivate func getCardsFromWebsite(){
    HttpDownloader.loadFileAsync(URL(string: Deck.CARDS_URL)!,
                                 completion: { (path, error) -> Void in
                                  if error == nil {
                                    self.loadCards(path);
                                  }
                                  else {
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

  fileprivate func loadCards(_ path:String) {
    // because this is happening from another thread, might as well lock it
    objc_sync_enter(deck)
    deck = parseCSV(path, encoding: String.Encoding.utf8, error: nil)
    objc_sync_exit(deck)
  }

  //adapted from
  //http://stackoverflow.com/questions/32313938/parsing-csv-file-in-swift
  //edit: that one sucked (like a lot) so i'm using CSwiftV now
  fileprivate func parseCSV (_ contentsOfFile: String, encoding: String.Encoding, error: NSErrorPointer) -> [Card] {
    var headCount:Int = 0;
    var muscleCount:Int = 0;
    var moxieCount:Int = 0;
    var randomCount:Int = 0;

    var ret:[Card] = [Card]()

    if let data = try? Data(contentsOf: URL(fileURLWithPath: contentsOfFile)) {
      if let content = NSString(data: data, encoding: String.Encoding.utf8.rawValue) {
        let csv = CSwiftV(with: content.description);
        let headers = csv.headers;
        if (!headers.contains("Type") ||
          !headers.contains("Title") ||
          !headers.contains("Stealable") ||
          !headers.contains("Playable") ||
          !headers.contains("Description")) {
          print("error, file doesn't have correct headers, using default")

          let bundleURL = Bundle.main.bundleURL
          let fileURL = bundleURL.appendingPathComponent(Deck.CARDS_DEFAULT_NAME)

          return self.parseCSV(fileURL.path, encoding: String.Encoding.utf8, error: nil);
        }

        for row in csv.keyedRows! {
          var suit:Card.Suit = Card.Suit.joke;
          var rank:Int = 0;
          switch row["Type"]! {
          case "M":
            fallthrough;
          case "head":
            headCount+=1
            rank = headCount;
            suit = Card.Suit.head;
          case "S":
            fallthrough;
          case "moxie":
            moxieCount+=1
            rank = moxieCount;
            suit = Card.Suit.moxie;
          case "C":
            fallthrough;
          case "random":
            randomCount+=1
            rank = randomCount
            suit = Card.Suit.random;
          case "B":
            fallthrough;
          case "muscle":
            muscleCount+=1
            rank = muscleCount
            suit = Card.Suit.muscle;
          default:break
          }

          let stealable:Bool = row["Stealable"] == "Y";
          let playable:Bool = row["Playable"] == "Y";

          ret.append(Card(suit: suit, rank: rank, stealable: stealable, playable: playable, shortDescription: row["Title"]!, longDescription: row["Description"]!))
        }
      }
    }
    return ret;
  }

  func shuffle() {
    print("shuffling");
    if (order.count != deck.count) {
      for i in 0...(deck.count-1) {
        order.append(i);
      }
    }
    order.shuffle()
  }

  func hasNextCard() -> Bool {
    return index < deck.count;
  }

  func nextCard() -> Card {
    if self.hasNextCard() {
      index += 1;
    }
    return deck[order[index-1]];
  }

  func undrawCard() {
    //taken from the extension where we shuffle. Shuffle one card back into the deck
    let j = Int(arc4random_uniform(UInt32(order.count - index))) + index
    guard index != j else { return }
    swap(&order[index], &order[j])
    
    index -= 1 // go back one index
  }
  
  
  
}
