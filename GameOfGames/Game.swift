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
    
    ///////////////////// game constants //////////////////////
    internal static let MIN_PLAYER_COUNT = 6;
    internal static let MAX_PLAYER_COUNT = 14;
    
    internal static let NUM_CARDS_TO_WIN = 20;
    
    internal static let RULEBOOK_URL = "http://nathanand.co/wp-content/uploads/2016/05/The-Game-of-Games-Rulebook.pdf";
    
    ///////////////////////////////////////////////////////////
    private static var singleton: Game = Game();
    
    private var deck: Deck = Deck();
    
    private var numPlayers = 0;
    private var currentTurn = 0;
    
    private var currentCard: Card = Card(suit: Card.Suit.Joke,rank: 0);
    
    private var team1:[Int] = [Int]()
    private var team2:[Int] = [Int]()
    
    private var team1Name:String = ""
    private var team2Name:String = ""
    
    private var playerOrder:[Int] = [Int]()
    
    private var playerNames:[String] = [String]()
    
    private var whichTeamGoesFirst:Int = 1; // team 1 goes first by default but this is changed later
    
    private var team1CardsWon:[Card] = [Card]()
    private var team2CardsWon:[Card] = [Card]()
    
    private var team1CardsPerRound:[Int] = [Int]()
    private var team2CardsPerRound:[Int] = [Int]()
    
    private var skipped:Bool = false;
    
    private init()
    {
    }
    
    class func getInstance() -> Game
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
    
    func drawCard() -> Card
    {
        self.skipped = false; // the last card was not skipped (yet)
        if deck.hasNextCard()
        {
            self.currentCard = deck.nextCard();
        }
        return currentCard;
        
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
            team1CardsWon.append(currentCard)
            addOneToTeamInCurrentRound(1)
        }
        else // team 2
        {
            team2CardsWon.append(currentCard)
            addOneToTeamInCurrentRound(2)
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
            team2CardsWon.append(currentCard)
            addOneToTeamInCurrentRound(2);
        }
        else // team 2 -> 1 steals
        {
            team1CardsWon.append(currentCard)
            addOneToTeamInCurrentRound(1)
        }
        
        self.advanceTurn();
    }
    
    func addOneToTeamInCurrentRound(which:Int)
    {
        let roundNum = self.getCurrentRound()-1; // zero indexing
        if which == 1
        {
            while (team1CardsPerRound.count < roundNum)
            {
                //it's a while just in case they didn't get any cards in previous rounds
                team1CardsPerRound.append(0);
            }
            team1CardsPerRound[roundNum] += 1;

        }
        else if which == 2
        {
            while (team2CardsPerRound.count < roundNum)
            {
                //it's a while just in case they didn't get any cards in previous rounds
                team2CardsPerRound.append(0);
            }
            team2CardsPerRound[roundNum] += 1;
        }
    }
    
    func skipCard()
    {
        self.skipped = true;
    }
    
    func cardWasSkipped() -> Bool
    {
        return self.skipped;
    }
    
    func isNewRound() -> Bool
    {
        return (currentTurn % numPlayers) == 0;
    }
    
    func getTeamCardsInLastRound(team:Int) -> Int
    {
        if self.getCurrentRound() < 2
        {
            //there was no last round
            return 0;
        }
        return self.getTeamCardsInRound(team, round: self.getCurrentRound()-1);
    }
    
    func getTeamCardsInCurrentRound(team:Int) -> Int
    {
        return self.getTeamCardsInRound(team, round: self.getCurrentRound());
    }

    
    func getTeamCardsInRound(team:Int, round:Int) -> Int
    {
        if team == 1
        {
            return team1CardsPerRound[round-1]
        }
        else if team == 2
        {
            return team2CardsPerRound[round-1]
        }
        return 0;
    }
    
    func getCardsWonInLastRound() -> Int
    {
        if self.getCurrentRound() < 2
        {
            //there was no last round
            return 0;
        }
        return self.getCardsWonInRound(self.getCurrentRound()-1);
    }
    
    func getCardsWonInCurrentRound() -> Int
    {
        return self.getCardsWonInRound(self.getCurrentRound());
    }

    func getCardsWonInRound(round:Int) -> Int
    {
        return team1CardsPerRound[round-1] + team2CardsPerRound[round-1]
    }
    
    func quickStart(players:Int)
    {
        print("quick starting");
        self.setNumPlayers(players);
        team1Name = "The Crustaceans"
        team2Name = "The Fish"
        playerNames = ["Lobster", "Great White", "Crab", "Tuna","Shrimp", "Manta Ray", "Barnacle", "Swordfish", "Krill", "Eel", "Crayfish", "BlowFish", "Prawn", "Flounder"]
    }

    
}