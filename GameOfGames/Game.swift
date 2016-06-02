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
    //IF CHANGED HERE, CHANGE IN STORYBOARD AS WELL AT NUMBER OF PLAYERS VIEW CONTROLLER
    internal static let MIN_PLAYER_COUNT = 6;
    internal static let MAX_PLAYER_COUNT = 14;
    
    internal static let NUM_CARDS_TO_WIN = 20;
    
    private static var singleton: Game = Game();
    
    private var deck: Deck = Deck();
    
    private var numPlayers = 0;
    private var currentTurn = 0;
    
    private var currentCard: Card? = nil;
    
    private var team1:[Int] = [Int]()
    private var team2:[Int] = [Int]()
    
    private var team1Name:String = ""
    private var team2Name:String = ""
    
    private var playerOrder:[Int] = [Int]()
    
    private var playerNames:[String] = [String]()
    
    private var whichTeamGoesFirst:Int = 1;
    
    private var team1CardsWon:[Card] = [Card]()
    private var team2CardsWon:[Card] = [Card]()
    
    private var skipped:Bool = false;
    
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
        playerNames = [String](count:num, repeatedValue: "");
        
        self.playerOrder = [Int]()
        
        var i = 3; // 3 is the first variable player; 1 and 2 are captains
        while i <= self.numPlayers
        {
            self.playerOrder.append(i);
            i += 1;
        }
        self.updateTeamsFromOrder()
    }
    
    private func updateTeamsFromOrder()
    {
        self.team1 = [1];
        self.team2 = [2];
        for i in 0...(playerOrder.count-1)
        {
            if i%2 == 0 // evens -> team 1 (cuz 0 indexing)
            {
                self.team1.append(playerOrder[i])
            }
            else // odds -> team 2
            {
                self.team2.append(playerOrder[i])
            }
        }
    }
    
    func getNumPlayers() -> Int
    {
        return self.numPlayers;
    }
    
    func setPlayerName(num:Int, name:String)
    {
        if (num <= self.numPlayers)
        {
            playerNames[num-1] = name;
        }
    }
    
    func getPlayerName(num:Int) -> String
    {
        return playerNames[num-1];
    }
    
    func shuffleTeams()
    {
        playerOrder.shuffleInPlace();
        
        self.updateTeamsFromOrder()
    }
    
    func getTeam(which:Int) -> [Int]
    {
        if which == 1
        {
            return team1
        }
        else if which == 2
        {
            return team2
        }
        else
        {
            return []
        }
    }
    
    func setTeamName(whichTeam:Int, name:String)
    {
        if whichTeam == 1
        {
            team1Name = name;
        }
        else if whichTeam == 2
        {
            team2Name = name;
        }
    }
    
    func getTeamName(whichTeam:Int) -> String
    {
        if whichTeam == 1
        {
            return team1Name
        }
        else if whichTeam == 2
        {
            return team2Name
        }
        return ""
    }
    
    func setTeamGoingFirst(team:Int)
    {
        if team == 1
        {
            whichTeamGoesFirst = 1;
        }
        if team == 2
        {
            whichTeamGoesFirst = 2;
        }
    }
    
    func getTeam1Score() -> Int
    {
        return team1CardsWon.count;
    }
    
    func getTeam1Cards() -> [Card]
    {
        return team1CardsWon;
    }
    
    func getTeam2Score() -> Int
    {
        return team2CardsWon.count;
    }
    
    func getTeam2Cards() -> [Card]
    {
        return team2CardsWon;
    }
    
    func getTeamScore(which : Int) -> Int
    {
        if which == 1
        {
            return team1CardsWon.count
        }
        if which == 2
        {
            return team2CardsWon.count
        }
        return 0;
    }

    func getTeamCards(which : Int) -> [Card]
    {
        if which == 1
        {
            return team1CardsWon
        }
        if which == 2
        {
            return team2CardsWon
        }
        return [];
    }

    
    func getCurrentRound() ->Int
    {
        return (currentTurn / numPlayers) + 1;
    }
    
    func getCurrentTurn() ->Int
    {
        return currentTurn + 1;
    }
    
    func getCurrentPlayer() -> Int
    {
        let numInRound = currentTurn % numPlayers;
        
        if numInRound%2 == (whichTeamGoesFirst==1 ? 0 : 1)
        {
            return team1[Int(numInRound/2)]
        }
        else
        {
            return team2[Int(numInRound/2)]
        }
    }
    
    func getCurrentPlayerName() -> String
    {
        return self.getPlayerName(self.getCurrentPlayer());
    }
    
    func getCurrentTeam() -> Int
    {
        let numInRound = currentTurn % numPlayers;
        
        if numInRound%2 == (whichTeamGoesFirst==1 ? 0 : 1)
        {
            return 1
        }
        else
        {
            return 2
        }

    }
    
    func getCurrentTeamName() ->String
    {
        return self.getTeamName(self.getCurrentTeam());
    }
    
    func hasNextCard() -> Bool
    {
        return deck.hasNextCard();
    }
    
    func drawCard() -> String?
    {
        self.skipped = false; // the last card was not skipped (yet)
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
    
    // shuffles the last card drawn back into the deck
    func undoLastTurn()
    {
        self.undrawCard() // shuffles it back into the deck
        //TODO: NEED TO REMOVE IT FROM WHOEVER WON IT'S CARDS
        currentTurn -= 1
    }
    
    func undrawCard()
    {
        deck.undrawCard() // shuffles it back into the deck
    }
    
    func getCurrentCard() -> Card?
    {
        return self.currentCard;
    }
    
    func advanceTurn()
    {
        currentTurn += 1;
    }
    
    func cardWasWon()
    {
        let numInRound = currentTurn % numPlayers;
        
        if numInRound%2 == (whichTeamGoesFirst==1 ? 0 : 1)
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
        
        if numInRound%2 == (whichTeamGoesFirst==1 ? 0 : 1) // even, first team (because 0 index) -> second team steals
        {
            team2CardsWon.append(currentCard!)
        }
        else // team 2 -> 1 steals
        {
            team1CardsWon.append(currentCard!)
        }
        self.advanceTurn();
    }
    
    func skipCard()
    {
        self.skipped = true;
    }
    
    func cardWasSkipped() -> Bool
    {
        return self.skipped;
    }
    
    func quickStart(players:Int)
    {
        self.setNumPlayers(players);
        team1Name = "The Crustaceans"
        team2Name = "The Fish"
        playerNames = ["Lobster", "Great White", "Crab", "Tuna","Shrimp", "Manta Ray", "Barnacle", "Swordfish", "Krill", "Eel", "Crayfish", "BlowFish", "Prawn", "Flounder"]
    }
    
}