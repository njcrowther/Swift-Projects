//
//  RookCard.swift
//  Matchismo3
//
//  Created by Nathan Crowther on 10/10/15.
//  Copyright © 2015 Nathan Crowther. All rights reserved.
//

import Foundation

class RookCard: PlayingCard {
    class var ROOK_RANK: Int { return 0 }
    class var ROOK_SUIT: String { return "K" }
    class var ROOK_SUIT_NAME: String { return "ROOK" }
    class var RANK_MATCH_SCORE: Int { return 4 }
    class var SUIT_MATCH_SCORE: Int { return 1 }
    
    
    func isRook() -> Bool {
        return suit == RookCard.ROOK_SUIT && rank == RookCard.ROOK_RANK
    }
    
    override func match(otherCards: [Card]) -> Int {
        var score = 0;
        
        if (otherCards.count == 1) {
            if let otherCard = otherCards.last as? RookCard {
                if otherCard.suit == suit {
                    score = self.dynamicType.SUIT_MATCH_SCORE
                } else if otherCard.rank == rank {
                    score = self.dynamicType.RANK_MATCH_SCORE
                }
            }
        }
        
        return score
    }
    
    override class func validRanks() -> [String] {
        return ["R", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14"]
    }
    
    override class func validSuits() -> [String] {
        return ["K", "R", "G", "B", "Y"]
    }
    
}