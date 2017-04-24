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
    case muscle, moxie, head, random

    //current name - old name - suit type
    //
    //   head      -  mind    - diamond
    //  muscle     -  body    -  spade
    //   moxie     -  soul    -  heart
    //  random     - chance   -  club
    
    func simpleDescription() -> String {
      switch self {
      case .joke:
        return "joke"
      case .head:
        return "Mind"
      case .muscle:
        return "Body"
      case .moxie:
        return "Soul"
      case .random:
        return "Chance"
      }
    }
    
    func wonMessageTitle() -> String {
      switch self {
      case .joke:
        return "Haha"
      case .head:
        return "Good Thinking"
      case .muscle:
        return "#muscleGoals"
      case .moxie:
        return "Take a Look at You!"
      case .random:
        return "It's Your Lucky Day!"
      }
    }
    func wonMessage() -> String {
      switch self {
      case .joke:
        return "Haha"
      case .head:
        return "Send some wine to any player on the other team"
      case .muscle:
        return "Send some beer to any player on the other team"
      case .moxie:
        return "Send a shot to any player on the other team"
      case .random:
        return "I hope another card is good enough because you don't get to send anything"
      }
    }

    
    func lostMessageTitle() -> String {
      switch self {
      case .joke:
        return "Haha"
      case .head:
        return "What Were You Thinking?"
      case .muscle:
        return "Do You Even Lift, Bro?"
      case .moxie:
        return "Not Mad, Just Disappointed"
      case .random:
        return "Better Luck Next Time!"
      }
    }
    func lostMessage() -> String {
      switch self {
      case .joke:
        return "Haha"
      case .head:
        return "You and a teammate must drink some wine"
      case .muscle:
        return "You and a teammate must drink some beer"
      case .moxie:
        return "You and a teammate must take a shot"
      case .random:
        return "At least your team doesn't have to drink anything!"
      }
    }

    
    func stolenMessageTitle() -> String {
      switch self {
      case .joke:
        return "Haha"
      case .head:
        return "Quick, But Not Quick Enough"
      case .muscle:
        return "You Oughta Hit the Gym"
      case .moxie:
        return "That Couldn't Have Felt Good"
      case .random:
        return "A random card was stolen?"
      }
    }
    func stolenMessage() -> String {
      switch self {
      case .joke:
        return "Haha"
      case .head:
        return "Have your counterpart send some wine to anyone on your team"
      case .muscle:
        return "Have your counterpart send some beer to anyone on your team"
      case .moxie:
        return "Have your counterpart send a shot to anyone on your team"
      case .random:
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
    case .head:
      return "a quarter glass of wine"
    case .muscle:
      return "a quarter can of beer"
    case .moxie:
      return "a shot of liquor"
    case .random:
      return "nothing"
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
