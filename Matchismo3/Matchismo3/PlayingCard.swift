//
//  PlayingCard.swift
//  Matchismo2
//
//  Created by Nathan Crowther on 9/26/15.
//  Copyright © 2015 Nathan Crowther. All rights reserved.
//

import Foundation

class PlayingCard: Card {
    private static let RANK_MATCH_SCORE2 = 4
    private static let SUIT_MATCH_SCORE2 = 1
   
    private static let RANK_MATCH_SCORE3 = 6
    private static let SUIT_MATCH_SCORE3 = 3
    
    var gameMode = ""
    
    var suit: String!{
        didSet {
            if !self.dynamicType.validSuits().contains(suit) {
                suit = "?"
            }
            contents = "\(self.dynamicType.validRanks()[rank])\(suit)"
        }
    }
    
    var rank: Int! {
        didSet {
            if rank < 0 || rank > self.dynamicType.maxRank() {
                rank = 0
            }
            contents = "\(self.dynamicType.validRanks()[rank])\(suit)"
        }
        
//        didSet {
//            if rank < 0 || rank > PlayingCard.maxRank() {
//                rank = 0
//            }
//            contents = "\(PlayingCard.rankStrings()[rank])\(suit)"
//        }
    }
    
    override func match(otherCards: [Card]) -> Int {
        var score = 0
        print("OtherCards.count = \(otherCards.count)")
        
        
        
        if otherCards.count == 1 {
            if let otherCard = otherCards.first as? PlayingCard { //as? Cast to PlayingCard
                if otherCard.suit == suit {
                    score = PlayingCard.SUIT_MATCH_SCORE2
                } else if otherCard.rank == rank {
                    score = PlayingCard.RANK_MATCH_SCORE2
                }
                
            }
        } else if otherCards.count == 2 {
            for cards in otherCards {
                print("otherCard: \(cards.contents)")
            }
            if let otherCard1 = otherCards[0] as? PlayingCard { //as? Cast to PlayingCard
                if let otherCard2 = otherCards[1] as? PlayingCard {
                    print("otherCard1 is \(otherCard1.contents), otherCard2 is \(otherCard2.contents)")
                    if otherCard1.suit == suit && otherCard2.suit == suit {
                        score = PlayingCard.SUIT_MATCH_SCORE3
                    } else if otherCard1.rank == rank && otherCard2.rank == rank {
                        score = PlayingCard.RANK_MATCH_SCORE3
                    }
                }
            }
        }
        
        return score
    }
    
    class func validSuits() -> [String] {
        return ["♥️", "♦️", "♠︎" , "♣︎"]
    }
    //rankStrings
    class func validRanks() -> [String] {
        return ["?", "A", "2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K"]
    }
    
    class func maxRank() -> Int {
        return validRanks().count - 1
    }
}