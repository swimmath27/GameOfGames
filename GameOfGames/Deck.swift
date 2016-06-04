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
    private static let CARDS_URL:String = "http://nathanand.co/wp-content/uploads/2016/06/Game-of-Games-Cards.csv"
    private static let CARDS_DEFAULT_NAME:String = "Game-of-Games-Cards-Default.csv"
    private static let CARDS_DOWNLOAD_NAME:String = "Game-of-Games-Cards.csv"
    
    private var deck = [Card]()
    private var order:[Int] = [Int]()
    private var index:Int = 0
    
    init()
    {
        //print(Deck.CARDS_URL);
        let bundleURL = NSBundle.mainBundle().bundleURL
        let fileURL = bundleURL.URLByAppendingPathComponent(Deck.CARDS_DOWNLOAD_NAME)
        let filemgr = NSFileManager();
        if filemgr.fileExistsAtPath(fileURL.path!)
        {
            //remove it so we can download one
            do
            {
                try filemgr.removeItemAtURL(fileURL)
                print("Remove successful")
            }
            catch
            {
                print("Failed to remove existing file")
            }
        }
        
        HttpDownloader.loadFileAsync(NSURL(string: Deck.CARDS_URL)!,
            completion:
            { (path, error) -> Void in
                if error == nil
                {
                    self.loadCards(path);
                }
                else
                {
                    //if there was an error, ignore it and load the default cards
                    print("error getting cards url, ignoring and loading defaults");
                    let bundleURL = NSBundle.mainBundle().bundleURL
                    let fileURL = bundleURL.URLByAppendingPathComponent(Deck.CARDS_DEFAULT_NAME)
                    
                    self.loadCards(fileURL.path!);
                }
                self.shuffle();
            })
    }
    
    private func loadCards(path:String)
    {
        deck = parseCSV(path, encoding: NSUTF8StringEncoding, error: nil)
    }
    
    private func parseCSV (contentsOfFile: String, encoding: NSStringEncoding, error: NSErrorPointer) -> [Card] {
        // Load the CSV file and parse it
        let delimiter = ","
        
        var mindCount:Int = 0;
        var bodyCount:Int = 0;
        var soulCount:Int = 0;
        var chanceCount:Int = 0;
        
        var ret:[Card] = [Card]()
        
        print("loading \"\(contentsOfFile)\"")
        
        if let data = NSData(contentsOfFile: contentsOfFile)
        {
            if let content = NSString(data: data, encoding: NSUTF8StringEncoding)
            {
                let lines : [String] = content.componentsSeparatedByCharactersInSet(NSCharacterSet.newlineCharacterSet()) as [String]
                
                for line in lines
                {
                    var values:[String] = []
                    if line != ""
                    {
                        // For a line with double quotes
                        // we use NSScanner to perform the parsing
                        if line.rangeOfString("\"") != nil
                        {
                            var textToScan:String = line
                            var value:NSString?
                            var textScanner:NSScanner = NSScanner(string: textToScan)
                            while textScanner.string != ""
                            {
                                
                                if (textScanner.string as NSString).substringToIndex(1) == "\""
                                {
                                    textScanner.scanLocation += 1
                                    textScanner.scanUpToString("\"", intoString: &value)
                                    textScanner.scanLocation += 1
                                }
                                else
                                {
                                    textScanner.scanUpToString(delimiter, intoString: &value)
                                }
                                
                                // Store the value into the values array
                                values.append(value as! String)
                                
                                // Retrieve the unscanned remainder of the string
                                if textScanner.scanLocation < textScanner.string.characters.count
                                {
                                    textToScan = (textScanner.string as NSString).substringFromIndex(textScanner.scanLocation + 1)
                                }
                                else
                                {
                                    textToScan = ""
                                }
                                textScanner = NSScanner(string: textToScan)
                            }
                            
                            // For a line without double quotes, we can simply separate the string
                            // by using the delimiter (e.g. comma)
                        }
                        else
                        {
                            values = line.componentsSeparatedByString(delimiter)
                        }
                        
                        
                        var suit:Card.Suit = Card.Suit.Joke;
                        var rank:Int = 0;
                        switch values[0]
                        {
                        case "M":
                            mindCount+=1
                            rank = mindCount;
                            suit = Card.Suit.Mind;
                        case "S":
                            soulCount+=1
                            rank = soulCount;
                            suit = Card.Suit.Soul;
                        case "C":
                            chanceCount+=1
                            rank = chanceCount
                            suit = Card.Suit.Chance;
                        case "B":
                            bodyCount+=1
                            rank = bodyCount
                            suit = Card.Suit.Body;
                        default:break
                        }
                        
                        let stealable:Bool = values[2] == "Y";
                        ret.append(Card(suit: suit, rank: rank, stealable: stealable, shortDescription: values[1], longDescription: values[3]))
//                        print(values[1]);
                        //type - values[0]
                        //name - values[1]
                        //stealable - values[2]
                        //description - values[3]
                    }
                }
            }
        }
        return ret;
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
        order.shuffleInPlace()
    }
    
    func hasNextCard() -> Bool
    {
        return index < deck.count;
    }
    
    func nextCard() -> Card
    {
        if self.hasNextCard()
        {
            index += 1;
        }
        return deck[order[index-1]];
    }
    
    func undrawCard()
    {
        //taken from the extension where we shuffle. Shuffle one card back into the deck
        let j = Int(arc4random_uniform(UInt32(order.count - index))) + index
        guard index != j else { return }
        swap(&order[index], &order[j])
        
        index -= 1 // go back one index
    }
    
    

}