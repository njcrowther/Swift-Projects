//
//  PlayingCardDeck.swift
//  Matchismo2
//
//  Created by Nathan Crowther on 9/26/15.
//  Copyright © 2015 Nathan Crowther. All rights reserved.
//

import Foundation

class PlayingCardDeck: Deck {
    override init() {
        super.init()
        
        for suit in PlayingCard.validSuits() {
            for rank in 1 ... PlayingCard.maxRank() {
                let card = PlayingCard()
                
                card.rank = rank
                card.suit = suit
                
                addCard(card, atTop: true)
            }
        }
    }
}