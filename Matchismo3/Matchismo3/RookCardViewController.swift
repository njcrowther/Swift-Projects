//
//  RookCardViewController.swift
//  Matchismo3
//
//  Created by Nathan Crowther on 10/7/15.
//  Copyright © 2015 Nathan Crowther. All rights reserved.
//

import UIKit

class RookCardViewController : UIViewController {
    lazy var deck = RookCardDeck()
    var firstCard = true
    
    @IBOutlet weak var rookCardView: RookCardView! {
        didSet {
            let recognizer = UIPinchGestureRecognizer()
            
            recognizer.addTarget(rookCardView, action: Selector("pinch:"))
            rookCardView.addGestureRecognizer(recognizer)
        }
    }
    
    func drawRandomRookCard() {
        var card: Card?
        
        if firstCard {
            card = deck.drawRandomCard()
            firstCard = false
        } else {
            card = deck.drawRandomCard()
        }
        
        if let rookCard = card as? RookCard {
            rookCardView.rank = rookCard.rank
            rookCardView.rankAsString = RookCard.validRanks()[rookCard.rank]
            rookCardView.suit = rookCard.suit
            
            let suits = RookCard.validSuits()
            
            for i in 0 ..< suits.count {
                if suits[i] == rookCard.suit {
                    
                }
            }
        }
    }
    
    @IBAction func swipe(sender: UISwipeGestureRecognizer) {
        UIView.transitionWithView(rookCardView, duration: 0.5, options: .TransitionFlipFromLeft, animations: {
            if !self.rookCardView.faceUp {
                self.drawRandomRookCard()
            }
            
            self.rookCardView.faceUp = !self.rookCardView.faceUp
            self.rookCardView.setNeedsDisplay()
            }, completion: nil)
        
        /*animation {if!self.rookCardView.faceUp {
            self.drawrandomrookcard()
        }*/
    }
}
