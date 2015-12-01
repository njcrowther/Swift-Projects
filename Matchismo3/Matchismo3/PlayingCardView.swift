//
//  PlayingCardView.swift
//  Matchismo3
//
//  Created by Nathan Crowther on 10/5/15.
//  Copyright © 2015 Nathan Crowther. All rights reserved.
//

import UIKit

class PlayingCardView: UIView {
    var cardBackImageName = "PlayingCardBack"
    var faceUp = false
    var rank = 0
    var suit = ""
    
    override func drawRect(rect: CGRect) {
        drawCardWithBackImage(cardBackImageName)
    }
    
    func drawCardWithBackImage(name: String) {
        let backImage = UIImage(named: name)
        
        backImage?.drawInRect(bounds)
    }
}
