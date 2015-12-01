//
//  CardMatchingGame.swift
//  Matchismo2
//
//  Created by Nathan Crowther on 9/28/15.
//  Copyright © 2015 Nathan Crowther. All rights reserved.
//

import Foundation

class CardMatchingGame {
    private static let FLIP_COST = 1
    private static let MATCH_BONUS = 4
    private static let MISMATCH_PENALTY = 2
    var gameMode = "2-Card"
    
    private var score = 0
    private var points = 0
    private var flip_description = ""
    private var startTime = NSDate()
    let userDefaults = NSUserDefaults.standardUserDefaults()
    
    var otherCardArray = [Card]()

    private var cards = [Card]()
    
    init(cardCount: Int, deck: Deck) {
        for _ in 0 ..< cardCount {
            if let card = deck.drawRandomCard() {
                cards.append(card)
                //                card.playable = true
            }
        }
    }
    
    func getGameMode() -> String {
        return gameMode
    }
    
    
    func cardAtIndex(index: Int) -> Card? {
        if index >= 0 && index < cards.count {
            return cards[index]
        }
        
        return nil
    }
    
    func flipDescription(card1: Card, card2: Card?, card3: Card?, points: Int, match: Bool) -> String {
        /*
        if 1 card is faceUp: "Flipped up 8"
        else if 2 cards faceUp && Match: "Matched J & J for score_description
        else if 2 cards faceUp && !Match: "6 and J don't match: score_description penalty
        */
        switch gameMode {
            case "2-Card":
                if(match && card2 != nil) {
                    return "Matched \(card1.contents) & \(card2!.contents) for \(points) points!"
                }
                else if(!match && card2 != nil) {
                    return "\(card1.contents) does not match \(card2!.contents). \(points) Point Penalty."
                }
                else {
                    return "Flipped up \(card1.contents)!"
                }
            case "3-Card":
                if(match && card2 != nil && card3 != nil) {
                    return "Matched \(card1.contents), \(card2!.contents) & \(card3!.contents) for \(points) points!"
                }
                else if(!match && card2 != nil && card3 != nil) {
                    return "\(card1.contents), \(card2!.contents) & \(card3!.contents) do not match. \(points) Point Penalty."
                } else {
                    return "Flipped up \(card1.contents)!"
                }
        default:
            return ""
        }
        
    }
    
    func findFaceUp(allCards: [Card]) -> [Card] {
        var faceUpCards = [Card]()
        for card in allCards {
            if card.faceUp && card.playable {
                faceUpCards.append(card)
            }
        }
        return faceUpCards
    }
    
    func flipCardAtIndex(index: Int) {
        //create helper function that finds all other face up cards
        var matchScore = 0
        
        if let card = cardAtIndex(index) {
            
            if card.playable {
                //see if flipping this card up creates a match
                if !card.faceUp {
                    let faceUpCards = findFaceUp(cards)
                    flip_description = flipDescription(card, card2: nil, card3: nil, points: 0, match: false)
                    //what game mode is it
                    if faceUpCards.count == 1 && gameMode == "2-Card" {
                        matchScore = card.match(faceUpCards)
                        print("MatchScore is: \(matchScore)")
                    }
                    else if faceUpCards.count == 2 && gameMode == "3-Card" {
                        matchScore = card.match(faceUpCards)
                        print("MatchScore is: \(matchScore)")
                    }
                    
                    
                    if matchScore > 0 {
                        //otherCard.playable = false
                        for otherCard in faceUpCards {
                            otherCard.playable = false
                            
                        }
                        card.playable = false
                        points = matchScore * CardMatchingGame.MATCH_BONUS
                        score += points
                        
                        switch gameMode {
                            case "2-Card":
                            flip_description = flipDescription(card, card2: faceUpCards[0], card3: nil, points: points, match: true)
                            case "3-Card":
                            flip_description = flipDescription(card, card2: faceUpCards[0], card3: faceUpCards[1], points: points, match: true)
                        default:
                            flip_description = ""
                        }
                    } else {
                        points = CardMatchingGame.MISMATCH_PENALTY
                        score -= points
                        flip_description = flipDescription(card, card2: nil, card3: nil, points: points, match: false)
                    }
                    //Always charge for flipping a card
                    score -= CardMatchingGame.FLIP_COST
                }
                
                card.faceUp = !card.faceUp
            }
        }
    }
    
    
    
    
    func currentStartTime() -> NSDate {
        return startTime
    }
    
    
    func currentScore() -> Int {
        return score
    }
    
    func currentDescription() -> String {
        return flip_description
    }
    
 
    

}

/*
3 card mathing game
if otherCards.count == 2 //3 card game
set game matching mode in CardGame object

History
- NSUserDefaults
- GameResulatsViewController
- GameResult
- start time, date time, last update time (last time card flipped), array of game results, store in property list
Display
-   FlipcardatIndex -> what is the string I'm going to display
-   UIKit stuff should not go into model. Do Not import UIKit
-   Helper: what cards are faceUp
-   Helper: what is the most recent flip status
-   updateUI()


Segmented Control
property on card matching game to check status, share with card match function, disable it once game starts

Deal
- clear game, make new deck

Score
-   Text View
*/




/*
if let card = cardAtIndex(index) {
if card.playable {

//see if flipping this card up creates a match
if let card = cardAtIndex(index) {
if card.playable {

//see if flipping this card up creates a match
if !card.faceUp {
flip_description = flipDescription(card, card2: nil, points: 0, match: false)
for otherCard in cards {
if otherCard.faceUp && otherCard.playable {
let matchScore = card.match(faceUpCards,gameMode: gameMode)

if matchScore > 0 {
otherCard.playable = false
card.playable = false
points = matchScore * CardMatchingGame.MATCH_BONUS
score += points
flip_description = flipDescription(card, card2: otherCard, points: points, match: true)
} else {
points = CardMatchingGame.MISMATCH_PENALTY
score -= points
flip_description = flipDescription(card, card2: otherCard, points: points, match: false)
}

//We've found the other face-up playable card, so stop looking
break
}
}


//Always charge for flipping a card
score -= CardMatchingGame.FLIP_COST
}

card.faceUp = !card.faceUp
}
}

*/