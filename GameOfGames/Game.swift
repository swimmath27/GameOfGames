//
//  Game.swift
//  GameOfGames
//
//  Created by Michael Lombardo on 5/31/16.
//  Copyright © 2016 Michael Lombardo. All rights reserved.
//


import Foundation
//import UIKit


class Game
{
    internal static let MIN_PLAYER_COUNT = 4;
    internal static let MAX_PLAYER_COUNT = 20;
    internal static let NUM_CARDS_TO_WIN = 20;
    
    private static var singleton: Game = Game();
    
    private var deck: Deck = Deck();
    
    private var numPlayers = 0;
    private var currentTurn = 0;
    
    private var currentCard: Card? = nil;
    
    private var team1:[Int] = [Int]()
    private var team2:[Int] = [Int]()
    
    private var team1CardsWon:[Card] = [Card]()
    private var team2CardsWon:[Card] = [Card]()
    
    private init()
    {
        deck.shuffle();
    }
    
    static func getInstance() -> Game
    {
        return singleton;
    }
    
    func setNumPlayers(num: Int)
    {
        self.numPlayers = num;
    }
    
    func getNumPlayers() -> Int
    {
        return self.numPlayers;
    }
    
    func setTeams(team1:[Int],team2:[Int])
    {
        self.team1 = team1;
        self.team2 = team2;
    }
    
    func getTeam1Score() -> Int
    {
        return team1CardsWon.count;
    }
    
    func getTeam2Score() -> Int
    {
        return team2CardsWon.count;
    }
    
    func advanceTurn()
    {
        currentTurn += 1;
    }
    
    func getCurrentPlayer() -> Int
    {
        let numInRound = currentTurn % numPlayers;
        
        if numInRound%2 == 0 // even, team 1 (because 0 index) NOTE: DIFFERENT FROM RANDOMIZE TEAMS VIEW CONTROLLER
        {
            return team1[Int(numInRound/2)]
        }
        else
        {
            return team2[Int(numInRound/2)]
        }
    }
    
    func hasNextCard() -> Bool
    {
        return deck.hasNextCard();
    }
    
    func drawCard() -> String?
    {
        if deck.hasNextCard()
        {
            self.currentCard = deck.nextCard();
            return currentCard!.toString();
        }
        else
        {
            return nil;
        }
    }
    
    func cardWasWon()
    {
        let numInRound = currentTurn % numPlayers;
        
        if numInRound%2 == 0 // even, team 1 (because 0 index)
        {
            team1CardsWon.append(currentCard!)
        }
        else // team 2
        {
            team2CardsWon.append(currentCard!)
        }
        
        self.advanceTurn();
    }
    
    func cardWasLost()
    {
        self.advanceTurn();
    }
    
    func cardWasStolen()
    {
        let numInRound = currentTurn % numPlayers;
        
        if numInRound%2 == 0 // even, team 1 (because 0 index) -> team 2 steals
        {
            team2CardsWon.append(currentCard!)
        }
        else // team 2 -> 1 steals
        {
            team1CardsWon.append(currentCard!)
        }
        self.advanceTurn();
    }
    
    
}