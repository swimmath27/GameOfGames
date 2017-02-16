//
//  Card.swift
//  GameOfGames
//
//  Created by Michael Lombardo on 5/31/16.
//  Copyright © 2016 Michael Lombardo. All rights reserved.
//

import Foundation

class Card : Equatable {
  //taken from http://stackoverflow.com/questions/24007461/how-to-enumerate-an-enum-with-string-type
  
  enum Suit: Int {
    case joke = 0 // 1 starts the actual types
    case body, soul, mind, chance
    
    //mind - diamond
    //body - spade
    //soul - heart
    //chance - club
    
    func simpleDescription() -> String {
      switch self {
      case .joke:
        return "Joke"
      case .body:
        return "Body"
      case .soul:
        return "Soul"
      case .mind:
        return "Mind"
      case .chance:
        return "Chance"
      }
    }
    
    func wonMessageTitle() -> String {
      switch self {
      case .joke:
        return "Haha"
      case .body:
        return "#BodyGoals"
      case .soul:
        return "Take a Look at You!"
      case .mind:
        return "Good Thinking"
      case .chance:
        return "It's Your Lucky Day!"
      }
    }
    func wonMessage() -> String {
      switch self {
      case .joke:
        return "Haha"
      case .body:
        return "Add some beer into the Bitch Cup and send some beer to any player on the other team"
      case .soul:
        return "Add a shot into the Bitch Cup and send a shot to any player on the other team"
      case .mind:
        return "Add some wine into the Bitch Cup and send some wine to any player on the other team"
      case .chance:
        return "I hope another card is good enough because you don't get to send or pour anything"
      }
    }

    
    func lostMessageTitle() -> String {
      switch self {
      case .joke:
        return "Haha"
      case .body:
        return "Do You Even Lift, Bro?"
      case .soul:
        return "Not Mad, Just Disappointed"
      case .mind:
        return "What Were You Thinking?"
      case .chance:
        return "Better Luck Next Time!"
      }
    }
    func lostMessage() -> String {
      switch self {
      case .joke:
        return "Haha"
      case .body:
        return "You and a teammate must drink some beer"
      case .soul:
        return "You and a teammate must take a shot"
      case .mind:
        return "You and a teammate must drink some wine"
      case .chance:
        return "At least your team doesn't have to drink anything!"
      }
    }

    
    func stolenMessageTitle() -> String {
      switch self {
      case .joke:
        return "Haha"
      case .body:
        return "You Oughta Hit the Gym"
      case .soul:
        return "That Couldn't Have Felt Good"
      case .mind:
        return "Quick, But Not Quick Enough"
      case .chance:
        return "A Chance card was stolen?"
      }
    }
    func stolenMessage() -> String {
      switch self {
      case .joke:
        return "Haha"
      case .body:
        return "Add some beer to the Bitch Cup and your counterpart sends some beer to anyone on your team"
      case .soul:
        return "Add a shot to the Bitch Cup and your counterpart sends a shot to anyone on your team"
      case .mind:
        return "Add some wine to the Bitch Cup and your counterpart sends some wine to anyone on your team"
      case .chance:
        return "This shouldn't be possible"
      }
    }
  }
  
  fileprivate(set) var rank:Int = 0;
  fileprivate(set) var suit:Suit = Suit.joke;
  fileprivate(set) var stealable:Bool = false;
  fileprivate(set) var playable:Bool = false;
  fileprivate(set) var shortDesc:String = "";
  fileprivate(set) var longDesc:String = "";

  convenience init (suit:Suit, rank:Int) {
    self.init(suit: suit, rank: rank, stealable: false, playable: false, shortDescription: "", longDescription: "");
  }
  
  init (suit:Suit, rank:Int, stealable:Bool, playable: Bool, shortDescription:String, longDescription:String) {
    self.suit = suit;
    self.rank = rank;
    self.stealable = stealable;
    self.playable = playable;
    self.shortDesc = shortDescription;
    self.longDesc = longDescription;
  }
  
  
  func getDrink() -> String {
    switch suit {
    case .joke:
      return "nothing"
    case .body:
      return "a quarter can of beer"
    case .chance:
      return "nothing"
    case .mind:
      return "a quarter glass of wine"
    case .soul:
      return "a shot of liquor"
    }
  }
  
  
  func getStolenMessage() -> String {
    return self.suit.stolenMessage()
  }
  func getStolenMessageTitle() -> String {
    return self.suit.stolenMessageTitle();
  }
  
  
  func getWonMessage() -> String {
    return self.suit.wonMessage();
  }
  func getWonMessageTitle() -> String {
    return self.suit.wonMessageTitle();
  }
  
  
  func getLostMessage() -> String {
    return self.suit.lostMessage();
  }
  func getLostMessageTitle() -> String {
    return self.suit.lostMessageTitle();
  }
  
  
  func getFileName() ->String {
    return "\(self.suit.simpleDescription())_\(self.rank).png"
  }
  
  func toString() -> String {
    return "\(self.suit.simpleDescription()) card number \(self.rank)"
  }
}

//Equatable
func ==(lhs:Card, rhs:Card) -> Bool {
  return lhs.rank == rhs.rank && lhs.suit == rhs.suit
}
