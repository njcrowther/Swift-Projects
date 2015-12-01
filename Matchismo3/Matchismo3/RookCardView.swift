//
//  RookCardView.swift
//  Matchismo3
//
//  Created by Nathan Crowther on 10/7/15.
//  Copyright © 2015 Nathan Crowther. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(r: Int, g: Int, b: Int) {
        self.init(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: 1.0)
    }
}

class RookCardView : UIView {
    enum Suit : String {
        case Rook = "ROOK"
        case Red = "RED"
        case Green = "GREEN"
        case Yellow = "YELLOW"
        case Black = "BLACK"
        
        static func suitForString(string: String) -> Suit? {
            return Suit(rawValue: string.uppercaseString)
        }
    }
    
    // MARK: Constants
    func UNDERLINE_INSET() -> CGFloat { return bounds.size.width * 0.0111 }
    
    // MARK: Properties
    
    
    var faceUp = false
    var rank = 0
    var rankAsString = ""
    var rookCardScaleFactor: CGFloat = 0.9
    var suit = ""
    var suitName = Suit.Rook
    var suitColors = [ Suit.Rook    : UIColor(r: 34, g: 193, b: 196),
                        Suit.Red    : UIColor(r: 237, g: 37, b: 50),
                        Suit.Green  : UIColor(r: 36, g: 193, b: 80),
                        Suit.Yellow : UIColor(r:242, g: 199, b: 58),
                        Suit.Black  : UIColor.blackColor() ]
    
    override func drawRect(rect: CGRect) {
        let roundedRect = UIBezierPath(roundedRect: bounds, cornerRadius: bounds.size.width * 0.05)
        
        roundedRect.addClip()
        UIColor.whiteColor().setFill()
        UIColor.blackColor().setStroke()
        roundedRect.lineWidth = 1.0
        roundedRect.fill()
        roundedRect.stroke()
        
        if faceUp {
            let font = UIFont(name: "Palatino-Bold", size: bounds.size.width * 0.55)!
            
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .Center
            
            let rankString = NSAttributedString(string: rankAsString, attributes: [
                NSParagraphStyleAttributeName : paragraphStyle,
                NSFontAttributeName : font,
                NSForegroundColorAttributeName : suitColors[suitName]!
            ])
            
            var textBounds = CGRectZero
            
            textBounds.size = rankString.size()
            textBounds.origin = CGPointMake((bounds.size.width - textBounds.size.width) / 2.0, (bounds.size.height - textBounds.size.height) / 2.0)
            rankString.drawInRect(textBounds)
            
            if rank == 6 || rank == 9 {
                let underline = UIBezierPath()
                let yOffset = textBounds.origin.y + textBounds.size.height + font.descender + bounds.size.width * 0.333
                let xInset = UNDERLINE_INSET()

                underline.moveToPoint(CGPointMake(textBounds.origin.x + xInset, yOffset))
                underline.addLineToPoint(CGPointMake(textBounds.origin.x + textBounds.size.width, yOffset))
                underline.lineWidth = xInset
                
                underline.stroke()
            }
            
            let rect = UIBezierPath()
            let squareMargin: CGFloat = bounds.size.width * 0.189
            let width = bounds.size.width - (2.0 * squareMargin)
            let yOffSet = (bounds.size.height - width) / 2.0
            
            rect.lineWidth = bounds.size.width * 0.005
            rect.moveToPoint(CGPointMake(squareMargin, yOffSet))
            rect.addLineToPoint(CGPointMake(squareMargin + width, yOffSet))
            rect.addLineToPoint(CGPointMake(squareMargin + width, yOffSet + width))
            rect.addLineToPoint(CGPointMake(squareMargin, yOffSet + width))
            rect.closePath()
            rect.stroke()
            
        } else {
            let cardBackImage = UIImage(named: "RookCardBack")
            
            cardBackImage?.drawInRect(bounds)
        }
    }
    
    func pinch(recognizer: UIPinchGestureRecognizer) {
        if recognizer.state == UIGestureRecognizerState.Changed || recognizer.state == UIGestureRecognizerState.Ended {
            self.rookCardScaleFactor += recognizer.scale
            recognizer.scale = 1
            setNeedsDisplay()
        }
    }
}
