//
//  GameState.swift
//  TempleFlash
//
//  Created by Nathan Crowther on 10/28/15.
//  Copyright © 2015 Nathan Crowther. All rights reserved.
//

import Foundation


class GameState {
	var gameTempleArray = Temple.TEMPLES	//Array for temple images
	var studyTempleArray = Temple.TEMPLES	//Array for Study Mode
	var tableTempleArray = Temple.TEMPLES	//Array for temple names table
	var copyTempleArray = Temple.TEMPLES	//Array for creating gameTempleArray (see initializer)
	var correct = 0
	var incorrect = 0
	let time = UInt32(NSDate().timeIntervalSinceReferenceDate)

	
	init() {
		let arrayCount = gameTempleArray.count
		srand(time)
		var index: Int
		
		for i in 0...(arrayCount-1) {		//Shuffles Temple array
			index = Int(rand()) % copyTempleArray.count
			gameTempleArray[i] = copyTempleArray[index]
			copyTempleArray.removeAtIndex(index)
		}
		
		
    }
	
	func match(templeImage: String, templeTable: String) -> Bool {
		if templeImage == templeTable {
			correct++
			return true
		}
		else {
			incorrect++
			return false
		}
		

	}
	
	func deleteIfMatch(cellIndex: NSIndexPath, tableIndex: Int) {
		
	}
	
	
}