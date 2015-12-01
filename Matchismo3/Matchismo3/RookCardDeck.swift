//
//  RookCardDeck.swift
//  SuperCard
//
//  Created by Steve Liddle on 10/1/14.
//  Copyright (c) 2014 IS 543. All rights reserved.
//

import Foundation

class RookCardDeck : Deck {
    override init() {
        super.init()

        for suit in RookCard.validSuits() {
            if suit != RookCard.ROOK_SUIT {
                for rank in 1 ... RookCard.maxRank() {
                    let card = RookCard()
                    
                    card.rank = rank;
                    card.suit = suit;
                    
                    addCard(card, atTop: false)
                }
            }
        }
        
        let rook = RookCard()
        
        rook.rank = RookCard.ROOK_RANK
        rook.suit = RookCard.ROOK_SUIT
        
        addCard(rook, atTop: false)
    }
}