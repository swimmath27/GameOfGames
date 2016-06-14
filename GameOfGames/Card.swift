//
//  Card.swift
//  GameOfGames
//
//  Created by Michael Lombardo on 5/31/16.
//  Copyright © 2016 Michael Lombardo. All rights reserved.
//

import Foundation

class Card : Equatable
{
    //taken from http://stackoverflow.com/questions/24007461/how-to-enumerate-an-enum-with-string-type
    
    enum Suit: Int {
        case Joke = 0 // 1 starts the actual types
        case Body, Soul, Mind, Chance
        
        //mind - diamond
        //body - spade
        //soul - heart
        //chance - club
        
        func simpleDescription() -> String
        {
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
        
        func wonMessageTitle() -> String
        {
            switch self {
            case .Joke:
                return "Haha"
            case .Body:
                return "#BodyGoals"
            case .Soul:
                return "Take a Look at You!"
            case .Mind:
                return "Good Thinking"
            case .Chance:
                return "It's Your Lucky Day!"
            }
        }
        func wonMessage() -> String
        {
            switch self {
            case .Joke:
                return "Haha"
            case .Body:
                return "Add some beer into the Bitch Cup and send some beer to any player on the other team"
            case .Soul:
                return "Add a shot into the Bitch Cup and send a shot to any player on the other team"
            case .Mind:
                return "Add some wine into the Bitch Cup and send some wine to any player on the other team"
            case .Chance:
                return "I hope another card is good enough because you don't get to send or pour anything"
            }
        }

        
        func lostMessageTitle() -> String
        {
            switch self {
            case .Joke:
                return "Haha"
            case .Body:
                return "Do You Even Lift, Bro?"
            case .Soul:
                return "Not Mad, Just Disappointed"
            case .Mind:
                return "What Were You Thinking?"
            case .Chance:
                return "Better Luck Next Time!"
            }
        }
        func lostMessage() -> String
        {
            switch self {
            case .Joke:
                return "Haha"
            case .Body:
                return "You and a teammate must drink some beer"
            case .Soul:
                return "You and a teammate must take a shot"
            case .Mind:
                return "You and a teammate must drink some wine"
            case .Chance:
                return "At least your team doesn't have to drink anything!"
            }
        }

        
        func stolenMessageTitle() -> String
        {
            switch self {
            case .Joke:
                return "Haha"
            case .Body:
                return "You Oughta Hit the Gym"
            case .Soul:
                return "That Couldn't Have Felt Good"
            case .Mind:
                return "Quick, But Not Quick Enough"
            case .Chance:
                return "A Chance card was stolen?"
            }
        }
        func stolenMessage() -> String
        {
            switch self {
            case .Joke:
                return "Haha"
            case .Body:
                return "Add some beer to the Bitch Cup and your counterpart sends some beer to anyone on your team"
            case .Soul:
                return "Add a shot to the Bitch Cup and your counterpart sends a shot to anyone on your team"
            case .Mind:
                return "Add some wine to the Bitch Cup and your counterpart sends some wine to anyone on your team"
            case .Chance:
                return "This shouldn't be possible"
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
    
    
    func getStolenMessage() -> String
    {
        return self.suit.stolenMessage()
    }
    func getStolenMessageTitle() -> String
    {
        return self.suit.stolenMessageTitle();
    }
    
    
    func getWonMessage() -> String
    {
        return self.suit.wonMessage();
    }
    func getWonMessageTitle() -> String
    {
        return self.suit.wonMessageTitle();
    }
    
    
    func getLostMessage() -> String
    {
        return self.suit.lostMessage();
    }
    func getLostMessageTitle() -> String
    {
        return self.suit.lostMessageTitle();
    }
    
    
    func getFileName() ->String
    {
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

func ==(lhs:Card, rhs:Card) -> Bool
{
    return lhs.rank == rhs.rank && lhs.suit == rhs.suit
}
