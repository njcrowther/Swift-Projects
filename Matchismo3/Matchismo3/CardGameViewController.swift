//
//  CardGameViewController.swift
//  Matchismo2
//
//  Created by Nathan Crowther on 9/26/15.
//  Copyright © 2015 Nathan Crowther. All rights reserved.
//

import UIKit

class CardGameViewController: UIViewController {
    //    private lazy var cards = [ UIButton : Card ]()
    private var game: CardMatchingGame!
	private var score: Scores!
	
    @IBOutlet weak var flipsLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var flipDescriptionLabel: UILabel!
    
    @IBOutlet weak var cardButton: UIButton!
    
    

    
    @IBOutlet weak var gameMode: UISegmentedControl!
	
    @IBOutlet weak var testSegment: UILabel!
	
    @IBAction func gameModeChanged(sender: UISegmentedControl) {
        switch gameMode.selectedSegmentIndex {
        case 0:
            game.gameMode = "2-Card"
			print("2-Card Switch")
        case 1:
            game.gameMode = "3-Card"
			print("3-Card Switch")			
        default:
            break
        }
    }


    var flipCount: Int = 0 {
        didSet {
            flipsLabel.text = "Flips: \(flipCount)"
        }
    }
    
    @IBOutlet var cardButtons: [UIButton]! {
        didSet {
            game = CardMatchingGame(cardCount: cardButtons.count, deck: PlayingCardDeck())
			score = Scores()
        }
    }
    
    @IBAction func flipCard(sender: UIButton) {
        game.flipCardAtIndex(indexOfButton(sender))
        ++flipCount
		gameMode.enabled = false
		updateUI()
		
    }
    
    private func indexOfButton(button: UIButton) -> Int {
        for i in 0 ..< cardButtons.count {
            if button == cardButtons[i] {
                return i
            }
        }
        
        return -1
    }
    
    @IBAction func newDeal(sender: UIButton) {
		//Save State
		saveState()
		
		//Clear flipdescription when new deal
		game = CardMatchingGame(cardCount: cardButtons.count, deck: PlayingCardDeck())
        for button in cardButtons {
            button.enabled = true
        }
        flipCount = 0
		gameMode.enabled = true
		//game.gameMode = gameMode.selectedSegmentIndex.description
		print("GameMode after newDeal is \(game.gameMode)")
		flipDescriptionLabel.text = ""
        updateUI()
    }
    
    private func updateUI() {
        let cardBack = UIImage(named: "CardBack")
        let cardFront = UIImage(named: "CardFront")
        
        for button in cardButtons {
            let card = game.cardAtIndex(indexOfButton(button))!
            
            
            if card.faceUp {
                button.setTitle(card.contents, forState: .Normal)
                button.setBackgroundImage(cardFront, forState: .Normal)
                button.enabled = card.playable
                flipDescriptionLabel.text = game.currentDescription()
            } else {
                button.setTitle("", forState: .Normal)
                button.setBackgroundImage(cardBack, forState: .Normal)
            }
        }
		
		saveState()
        
        scoreLabel.text = "Score: \(game.currentScore())"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //cardButton.tintColor = UIColor.redColor()
    }
	
	//Write scores here
	func saveState() {
		let userDefaults = NSUserDefaults.standardUserDefaults()
		
		//Check if userDefaults already contains score
		var contains = false
		print("\(userDefaults.dictionaryRepresentation())")
		
		
		if let currentData = userDefaults.objectForKey("scoreKey") as? NSData {
			let unarc = NSKeyedUnarchiver(forReadingWithData: currentData)
			var baseScoreArray = unarc.decodeObjectForKey("root") as! [Scores]
			
			for var i = 0; i < baseScoreArray.count; i++ {
				if baseScoreArray[i].startTime == score.startTime {
					contains = true
					baseScoreArray[i].endTime = NSDate()
					baseScoreArray[i].points = game.currentScore()
				}
			}
			
			if contains {
				userDefaults.setObject(NSKeyedArchiver.archivedDataWithRootObject(baseScoreArray), forKey: "scoreKey")
			} else {
				baseScoreArray.append(score)
				userDefaults.setObject(NSKeyedArchiver.archivedDataWithRootObject(baseScoreArray), forKey: "scoreKey")
			}

		} else {
			userDefaults.setObject(NSKeyedArchiver.archivedDataWithRootObject([score]), forKey: "scoreKey")
		}
	}
	
	
}

