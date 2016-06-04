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
        case Joke = 0 // 1 starts the actual types
        case Body, Soul, Mind, Chance
        
        //mind - diamond
        //body - spade
        //soul - heart
        //chance - club
        
        func simpleDescription() -> String {
            switch self {
            case .Joke:
                return "Joke"
            case .Body:
                return "Body"
            case .Soul:
                return "Soul"
            case .Mind:
                return "Mind"
            case .Chance:
                return "Chance"
            }
        }
    }
    
    private var rank:Int = 0;
    private var suit:Suit = Suit.Joke;
    private var stealable:Bool = false;
    private var shortDesc:String = "";
    private var longDesc:String = "";

    convenience init (suit:Suit, rank:Int)
    {
        self.init(suit: suit, rank: rank, stealable: false, shortDescription: "", longDescription: "");
    }
    
    init (suit:Suit, rank:Int, stealable:Bool, shortDescription:String, longDescription:String)
    {
        self.suit = suit;
        self.rank = rank;
        self.stealable = stealable;
        self.shortDesc = shortDescription;
        self.longDesc = longDescription;
    }
    
    func getDrink() -> String
    {
        switch suit
        {
        case .Joke:
            return "nothing"
        case .Body:
            return "a quarter can of beer"
        case .Chance:
            return "nothing"
        case .Mind:
            return "a quarter glass of wine"
        case .Soul:
            return "a shot of liquor"
        }
    }
    
    func getShortDescription() -> String
    {
        return self.shortDesc;
    }
    
    func getLongDescription() -> String
    {
        return self.longDesc;
    }
    
    func getFileName() ->String
    {
//        return "sampleCard.png"
        return "\(self.suit.simpleDescription())_\(self.rank).png"
    }
    
    func isStealable() -> Bool
    {
        return stealable;
    }

    
    func toString() -> String
    {
        return "\(self.suit.simpleDescription()) card number \(self.rank)"
    }

}
