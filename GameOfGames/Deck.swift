//
//  Deck.swift
//  GameOfGames
//
//  Created by Michael Lombardo on 5/31/16.
//  Copyright © 2016 Michael Lombardo. All rights reserved.
//

import Foundation

class Deck
{
    var deck = [Card]()
    var order:[Int] = [Int]()
    var index:Int = 0
    
    convenience init()
    {
        self.init(withJokers: true);
    }
    
    init(withJokers:Bool)
    {
        var n = 1
        while let rank = Card.Rank(rawValue: n)
        {
            var m = 1
            while let suit = Card.Suit(rawValue: m)
            {
                deck.append(Card(suit: suit, rank: rank))
                m += 1 // ++ is "deprecated"...
            }
            n += 1
        }
        
        if (withJokers)
        {
            //add joker 1 and joker 2
            deck.append(Card(suit:Card.Suit.Joker, rank:Card.Rank.Ace))
            deck.append(Card(suit:Card.Suit.Joker, rank:Card.Rank.Two))
        }
        
        
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
        print(order)
        order.shuffleInPlace()
        print(order);
    }
    
    func hasNextCard() -> Bool
    {
        return index < deck.count;
    }
    
    func nextCard() -> Card?
    {
        if self.hasNextCard()
        {
            index += 1;
            return deck[order[index-1]];
        }
        else
        {
            return nil;
        }
    }
    
    

}