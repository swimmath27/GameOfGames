//
//  Card.swift
//  GameOfGames
//
//  Created by Michael Lombardo on 5/31/16.
//  Copyright © 2016 Michael Lombardo. All rights reserved.
//

import Foundation

class Card
{
    //taken from http://stackoverflow.com/questions/24007461/how-to-enumerate-an-enum-with-string-type
    
    enum Suit: Int {
        case Joker = 0 // 1 starts the actual types
        case Spades, Hearts, Diamonds, Clubs
        func simpleDescription() -> String {
            switch self {
            case .Joker:
                return "joker"
            case .Spades:
                return "spades"
            case .Hearts:
                return "hearts"
            case .Diamonds:
                return "diamonds"
            case .Clubs:
                return "clubs"
            }
        }
        func color() -> String {
            switch self {
            case .Joker:
                return "none"
            case .Spades:
                return "black"
            case .Clubs:
                return "black"
            case .Diamonds:
                return "red"
            case .Hearts:
                return "red"
            }
        }
    }
    
    enum Rank: Int {
        case Ace = 1
        case Two, Three, Four, Five, Six, Seven, Eight, Nine, Ten
        case Jack, Queen, King
        func simpleDescription() -> String {
            switch self {
            case .Ace:
                return "ace"
            case .Jack:
                return "jack"
            case .Queen:
                return "queen"
            case .King:
                return "king"
            default:
                return String(self.rawValue)
            }
        }
    }
    
    private var rank:Rank = Rank.Ace;
    private var suit:Suit = Suit.Spades;

    init (suit:Suit, rank:Rank)
    {
        self.suit = suit;
        self.rank = rank;
    }
    
    func getDrink() -> String {
        switch suit {
        case .Joker:
            return "nothing"
        case .Spades:
            return "quarter can of beer"
        case .Clubs:
            return "nothing"
        case .Diamonds:
            return "quarter glass of wine"
        case .Hearts:
            return "shot of Liquor"
        }
    }

    
    func toString() -> String
    {
        if (self.suit == Suit.Joker)
        {
            return "Joker number \(self.rank.rawValue)";
        }
        return "The \(self.rank.simpleDescription()) of \(self.suit.simpleDescription())"
    }

}
