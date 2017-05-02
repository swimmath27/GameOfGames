//
//  Game.swift
//  GameOfGames
//
//  Created by Michael Lombardo on 5/31/16.
//  Copyright © 2016 Michael Lombardo. All rights reserved.
//

import Foundation
//import UIKit

class Game {
  
  ///////////////////// game constants //////////////////////
  internal static let MIN_PLAYER_COUNT = 6;
  internal static let MAX_PLAYER_COUNT = 14;
  
  internal static let NUM_CARDS_TO_WIN = 20;
  
  internal static let RULEBOOK_URL = "http://nathanand.co/wp-content/uploads/2016/05/The-Game-of-Games-Rulebook.pdf";

  ///////////////////////////////////////////////////////////
  fileprivate(set) static var instance: Game = Game();
  
  fileprivate var deck: Deck = Deck();
  
  fileprivate var numPlayers = 0;
  fileprivate var currentTurn = 0;
  
  fileprivate var currentCard: Card = Card(suit: Card.Suit.joke,rank: 0);
  
  fileprivate var team1:[Int] = [Int]()
  fileprivate var team2:[Int] = [Int]()
  
  fileprivate var team1Name:String = ""
  fileprivate var team2Name:String = ""
  
  fileprivate var playerOrder:[Int] = [Int]()

  fileprivate var players:[Player] = [Player]()
  
  fileprivate var whichTeamGoesFirst:Int = 1; // team 1 goes first by default but this is changed later

  fileprivate var team1CardsWon:[Card] = [Card]()
  fileprivate var team2CardsWon:[Card] = [Card]()

  fileprivate var team1CardsPerRound:[Int] = [Int]()
  fileprivate var team2CardsPerRound:[Int] = [Int]()
  
  fileprivate var quickStarted = false;

  fileprivate(set) var team1Score: Int = 0
  fileprivate(set) var team2Score: Int = 0
  
  //uh... "internal" means public?
  internal var messageTitle:String  = "";
  internal var message:String = "";
  
  internal var readyToGo:Bool = false;
  
  fileprivate init() { }
  
  class func load(_ completion: ()->()) {
    
  }
  
  class func getInstance() -> Game {
    return instance;
  }
  
  func getOrderedCards() -> [Card] {
    return self.deck.deck;
  }
  
  func setNumPlayers(_ num: Int) {
    self.numPlayers = num;
    players = [Player](repeating: Player(""), count: num);
    
    self.playerOrder = [Int]()
    
    var i = 3; // 3 is the first variable player; 1 and 2 are captains
    while i <= self.numPlayers {
      self.playerOrder.append(i);
      i += 1;
    }
    self.updateTeamsFromOrder()
  }
  
  fileprivate func updateTeamsFromOrder() {
    self.team1 = [1];
    self.team2 = [2];
    for i in 0...(playerOrder.count-1) {
      if i%2 == 0  {  // evens -> team 1 (cuz 0 indexing) 
        self.team1.append(playerOrder[i])
      }
      else  {  // odds -> team 2 
        self.team2.append(playerOrder[i])
      }
    }
  }
  
  func getNumPlayers() -> Int {
    return self.numPlayers;
  }
  
  func setPlayerName(_ num:Int, name:String) {
    if (num <= self.numPlayers) {
      players[num-1].setName(name);
    }
  }

  func getPlayer(_ num:Int) -> Player {
    return players[num-1];
  }
  func getPlayerName(_ num:Int) -> String {
    return players[num-1].name;
  }
  
  func shuffleTeams() {
    playerOrder.shuffle();
    
    self.updateTeamsFromOrder()
  }
  
  func getTeam(_ which:Int) -> [Int] {
    if which == 1 {
      return team1
    }
    else if which == 2 {
      return team2
    }
    else {
      return []
    }
  }
  
  func setTeamName(_ whichTeam:Int, name:String) {
    if whichTeam == 1 {
      team1Name = name;
    }
    else if whichTeam == 2 {
      team2Name = name;
    }
  }
  
  func getTeamName(_ whichTeam:Int) -> String {
    if whichTeam == 1 {
      return team1Name
    }
    else if whichTeam == 2 {
      return team2Name
    }
    return ""
  }
  
  func setTeamGoingFirst(_ team:Int) {
    if team == 1 {
      whichTeamGoesFirst = 1;
    }
    if team == 2 {
      whichTeamGoesFirst = 2;
    }
  }
  
  func getTeam1Score() -> Int {
    return team1Score;
  }
  
  func getTeam1Cards() -> [Card] {
    return team1CardsWon;
  }

  func addTeam1Score(_ score: Int) {
    team1Score += score;
  }

  func addTeam2Score(_ score: Int) {
    team2Score += score;
  }
  
  func getTeam2Score() -> Int {
    return team2Score;
  }
  
  func getTeam2Cards() -> [Card] {
    return team2CardsWon;
  }

  func getTeamScore(_ which : Int) -> Int {
    if which == 1 {
      return team1Score
    }
    if which == 2 {
      return team2Score
    }
    return 0;
  }

  func getTeamCards(_ which : Int) -> [Card] {
    if which == 1 {
      return team1CardsWon
    }
    if which == 2 {
      return team2CardsWon
    }
    return [];
  }

  
  func getCurrentRound() ->Int {
    return (currentTurn / numPlayers) + 1;
  }
  
  func getCurrentTurn() ->Int {
    return currentTurn + 1;
  }
  
  func getCurrentPlayer() -> Int {
    let numInRound = currentTurn % numPlayers;
    
    if numInRound%2 == (whichTeamGoesFirst==1 ? 0 : 1) {
      return team1[Int(numInRound/2)]
    }
    else {
      return team2[Int(numInRound/2)]
    }
  }
  
  func getCurrentPlayerName() -> String {
    return self.getPlayerName(self.getCurrentPlayer());
  }
  
  func getCurrentTeam() -> Int {
    let numInRound = currentTurn % numPlayers;
    
    if numInRound%2 == (whichTeamGoesFirst==1 ? 0 : 1) {
      return 1
    }
    else {
      return 2
    }

  }
  
  func getCurrentTeamName() ->String {
    return self.getTeamName(self.getCurrentTeam());
  }
  
  func hasNextCard() -> Bool {
    return deck.hasNextCard();
  }
  
  func drawCard() -> Card {
    if deck.hasNextCard() {
      self.currentCard = deck.nextCard();
    }
    return currentCard;
    
  }
  
  //todo: make sure this undoes everything we needed
  func undoLastTurn() {
    //we don't need to undraw a card because we won't draw a card, we'll simply use currentCard
    
    currentTurn -= 1
    if self.getCurrentTeam() == 1 && team1CardsWon.contains(currentCard) {
      team1CardsWon.remove( at: team1CardsWon.index(of: currentCard)!)
      team1CardsPerRound[self.getCurrentRound()] -= 1;
    }
    else if self.getCurrentTeam() == 2 && team2CardsWon.contains(currentCard) {
      team2CardsWon.remove( at: team2CardsWon.index(of: currentCard)!)
      team2CardsPerRound[self.getCurrentRound()] -= 1;
    }
  }
  
  // shuffles the last card drawn back into the deck
  func undoLastTurnAndReshuffle() {
    self.undrawCard() // shuffles it back into the deck
    //TODO: NEED TO REMOVE IT FROM WHOEVER WON IT'S CARDS
    currentTurn -= 1
  }
  
  func undrawCard() {
    deck.undrawCard() // shuffles it back into the deck
  }
  
  func getCurrentCard() -> Card? {
    return self.currentCard;
  }
  
  func advanceTurn() {
    currentTurn += 1;
  }
  
  func cardWasWon() {
    let numInRound = currentTurn % numPlayers;
    
    if numInRound%2 == (whichTeamGoesFirst==1 ? 0 : 1) {
      // team 1 won the card
      team1CardsWon.append(currentCard)
      if (currentCard.suit != .random) {
        // random cards aren't worth points
        addOneToTeamInCurrentRound(1)
      }
    }
    else  {  // team 2 won the card
      team2CardsWon.append(currentCard)
      if (currentCard.suit != .random) {
        // random cards aren't worth points
        addOneToTeamInCurrentRound(2)
      }
    }
    self.message = self.currentCard.getWonMessage()
    self.messageTitle = self.currentCard.getWonMessageTitle();
    
    self.advanceTurn();
  }
  
  func cardWasLost() {
    self.message = self.currentCard.getLostMessage()
    self.messageTitle = self.currentCard.getLostMessageTitle();
    
    self.advanceTurn();
  }
  
  func cardWasStolen() {
    let numInRound = currentTurn % numPlayers;
    
    if numInRound%2 == (whichTeamGoesFirst==1 ? 0 : 1)  {  // even, first team (because 0 index) -> second team steals 
      team2CardsWon.append(currentCard)
      addOneToTeamInCurrentRound(2);
    }
    else  {  // team 2 -> 1 steals 
      team1CardsWon.append(currentCard)
      addOneToTeamInCurrentRound(1)
    }
    self.message = self.currentCard.getStolenMessage()
    self.messageTitle = self.currentCard.getStolenMessageTitle();
    
    self.advanceTurn();
  }
  
  func addOneToTeamInCurrentRound(_ which:Int) {
    let roundNum = self.getCurrentRound()-1; // zero indexing
    if which == 1 {
      while (team1CardsPerRound.count <= roundNum) {
        //it's a while just in case they didn't get any cards in previous rounds
        team1CardsPerRound.append(0);
      }
      team1CardsPerRound[roundNum] += 1;

    }
    else if which == 2 {
      while (team2CardsPerRound.count <= roundNum) {
        //it's a while just in case they didn't get any cards in previous rounds
        team2CardsPerRound.append(0);
      }
      team2CardsPerRound[roundNum] += 1;
    }
  }
  
  func isNewRound() -> Bool {
    return (currentTurn % numPlayers) == 0;
  }
  
  func getTeamCardsInLastRound(_ team:Int) -> Int {
    if self.getCurrentRound() < 2 {
      //there was no last round
      return 0;
    }
    return self.getTeamCardsInRound(team, round: self.getCurrentRound()-1);
  }
  
  func getTeamCardsInCurrentRound(_ team:Int) -> Int {
    return self.getTeamCardsInRound(team, round: self.getCurrentRound());
  }

  func getTeamCardsInRound(_ team:Int, round:Int) -> Int {
    if team == 1 {
      while (team1CardsPerRound.count < round) {
        //it's a while just in case they didn't get any cards in previous rounds
        team1CardsPerRound.append(0);
      }
      return team1CardsPerRound[round-1]
    }
    else if team == 2 {
      //padd the array wiht 0's
      while (team2CardsPerRound.count < round) {
        //it's a while just in case they didn't get any cards in previous rounds
        team2CardsPerRound.append(0);
      }
      return team2CardsPerRound[round-1]
    }
    return 0;
  }
  
  func getCardsWonInLastRound() -> Int {
    if self.getCurrentRound() < 2 {
      //there was no last round
      return 0;
    }
    return self.getCardsWonInRound(self.getCurrentRound()-1);
  }
  
  func getCardsWonInCurrentRound() -> Int {
    return self.getCardsWonInRound(self.getCurrentRound());
  }

  func getCardsWonInRound(_ round:Int) -> Int {
    return team1CardsPerRound[round-1] + team2CardsPerRound[round-1]
  }
  
  func quickStart(_ playerCount:Int) {
    print("quick starting");
    quickStarted = true;
    
    self.setNumPlayers(playerCount);
    team1Name = "The Crustaceans"
    team2Name = "The Fish"

    self.players = [Player]();
    let playerNames = ["Lobster", "Great White", "Crab", "Tuna","Shrimp", "Manta Ray", "Barnacle", "Swordfish", "Krill", "Eel", "Crayfish", "BlowFish", "Prawn", "Flounder"]
    for name in playerNames {
      self.players.append(Player(name));
    }
  }
  
  func wasQuickStarted() -> Bool {
    return self.quickStarted;
  }
  
  func sendPlayerToEndOfTeam(_ playerIndex:Int, team:Int) {
    var index = playerIndex
    if (team != 1 && team != 2) {
      return
    }
    
    //shift that player to the back
    if (team == 1) {
      while index < team1.count-1 {
        swap(&team1[index], &team1[index+1])
        index += 1
      }
    }
    else if team == 2 {
      while index < self.getTeam(team).count-1 {
        swap(&team2[index], &team2[index+1])
        index += 1
      }
    }
  }
  
  func swapPlayersInTeam(_ player1:Int, player2:Int, team:Int) {
    
    if (team != 1 && team != 2) {
      return
    }
    
    //shift that player to the back
    if (team == 1) {
      if (player1 < 0 || player1 >= team1.count || player2 < 0 || player2 >= team1.count) {
        return
      }
      swap(&team1[player1], &team1[player2])
    }
    else if team == 2 {
      if (player1 < 0 || player1 >= team2.count || player2 < 0 || player2 >= team2.count) {
        return
      }
      swap(&team2[player1], &team2[player2])
    }
  }


  
}
