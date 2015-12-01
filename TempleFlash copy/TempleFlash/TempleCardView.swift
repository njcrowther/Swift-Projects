//
//  TempleCardView.swift
//  TempleFlash
//
//  Created by Nathan Crowther on 10/29/15.
//  Copyright © 2015 Nathan Crowther. All rights reserved.
//

import UIKit

class TempleCardView : UICollectionViewCell {
	var name = "Temple"
	var filename = "Temple"
//	var cellIsSelected = false
	var studyMode = false
	
	//MARK: Constants
	let TEMPLE_LABEL_FONT_SIZE = CGFloat(12)
	let TEMPLE_LABEL_FONT_COLOR = UIColor.whiteColor()

	let TEMPLE_LABEL_Y = CGFloat(25)
	
	
	//What mode are we painting in
	//What's the ratio
	
	override func drawRect(rect: CGRect) {

		
		//Draw Image
		drawCardWithImage()
		drawLabel()

		
		

		
	}
	
	func drawLabel() {
		//Draw label if in study mode
		if studyMode {
			//Draw rectangle
			let rectangleYPosition = self.bounds.height - 25
			
			let rectangle = CGRectMake(0, rectangleYPosition, self.bounds.width, 25)
			let gradient = UIBezierPath(rect: rectangle)
//			let newGradient = UIBezierPath(
			UIColor.darkGrayColor().setFill()

			gradient.fillWithBlendMode(.Normal, alpha: 0.75)

//			gradient.fill()

			
			
			//Draw Label
			let TempleLabelXPosition = CGFloat(5)
			let TempleLabelYPosition = (self.bounds.height / 2) + (self.bounds.height / 2.75)
			
			let TempleLabelLocation = CGPoint(x: TempleLabelXPosition, y: TempleLabelYPosition)

			let TempleLabelFont = UIFont(name: "Times New Roman", size: TEMPLE_LABEL_FONT_SIZE)!
			
			let label = NSAttributedString(string: name, attributes: [NSFontAttributeName: TempleLabelFont, NSForegroundColorAttributeName: TEMPLE_LABEL_FONT_COLOR])
			
			
			
			
			label.drawAtPoint(TempleLabelLocation)
			
		}
	}
	
	func drawCardWithImage() {
		let path = UIBezierPath(rect: self.bounds)

		UIColor.whiteColor().setStroke()
		UIColor.whiteColor().setFill()
		
		path.lineWidth = 2
		path.fill()
		path.stroke()
		
		let templeImage = UIImage(named: filename)!
		templeImage.drawInRect(CGRectInset(bounds, (bounds.size.width * 0.025), (bounds.size.height * 0.025)))
//		roundedRect.fill()
//		roundedRect.stroke()
		

		
//		if let templeImage = UIImage(named: filename) {
//			UIColor.whiteColor().setFill()
//			UIColor.blackColor().setStroke()
//			
//			let roundedRect = UIBezierPath(roundedRect: bounds, cornerRadius: 10)
//			
//			roundedRect.fill()
//			roundedRect.stroke()
//			
//			templeImage.drawInRect(CGRectInset(bounds, (bounds.size.width), (bounds.size.height)))
//		}
		
	}
}
