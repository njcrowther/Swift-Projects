//
//  Deck.swift
//  Matchismo2
//
//  Created by Nathan Crowther on 9/26/15.
//  Copyright © 2015 Nathan Crowther. All rights reserved.
//

import Foundation

class Deck {
    private lazy var cards = [Card]()
    
    func addCard(card: Card, atTop: Bool) {
        if atTop {
            cards.insert(card, atIndex: 0)
        } else {
            cards.append(card)
        }
    }
    
    func drawLastCard() -> Card? {
        var lastCard: Card?
        
        if cards.count > 0 {
            lastCard = cards.last
        }
        
        return lastCard
    }
    
    func drawRandomCard() -> Card? {
        var randomCard: Card?
        
        if cards.count > 0 {
            let index = Int(arc4random() % UInt32(cards.count))
            randomCard = cards[index]
            cards.removeAtIndex(index)
        }
        
        return randomCard
    }
}