//
//  TempleCardViewController.swift
//  TempleFlash
//
//  Created by Nathan Crowther on 10/29/15.
//  Copyright © 2015 Nathan Crowther. All rights reserved.
//

import UIKit
import AVFoundation

class TempleCardViewController : UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UITableViewDataSource, UICollectionViewDelegateFlowLayout, UITableViewDelegate {
	
	//MARK: Properties
	var Game: GameState!
	var studyMode = false
	var selectedCell = -1
	var selectedImageName = ""
	var selectedImageCell: UICollectionViewCell!
	var selectedTableCell = -1
	var selectedTableName = ""
	lazy var audioPlayer = AVAudioPlayer()
	
	
	//MARK: Constants
	let COLLECTION_CELL_HEIGHT = CGFloat(150)
	let AUDIO_PLAYER_VOLUME = Float(0.5)
	let CORRECT_SOUND = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("ding", ofType: "mp3")!)
	

	
	
	//MARK: Outlets
	@IBOutlet weak var borderViewWidthConstraint: NSLayoutConstraint!
	@IBOutlet weak var collectionView: UICollectionView!
	@IBOutlet weak var tableView: UITableView!
	@IBOutlet var gameView: UIView!
	// MARK: View controller lifecycle
	
	//MARK: Start Game
	override func viewDidLoad() {
		super.viewDidLoad()
		setUpGame()
		audioPlayer = try! AVAudioPlayer(contentsOfURL: CORRECT_SOUND)
		audioPlayer.volume = AUDIO_PLAYER_VOLUME
		audioPlayer.prepareToPlay()
	}
	

	
//########################################## COLLECTION VIEW ###########################################
	
	//MARK: Collection view data source
	func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCellWithReuseIdentifier("TempleCell", forIndexPath: indexPath)
		
		if studyMode {
			if let templeCard = cell as? TempleCardCollectionViewCell {
				templeCard.templeCardView.name = Game.studyTempleArray[indexPath.row].templeName
				templeCard.templeCardView.filename = Game.studyTempleArray[indexPath.row].fileName
//				templeCard.templeCardView.cellIsSelected = indexPath.row == selectedCell
				templeCard.templeCardView.studyMode = studyMode
				templeCard.templeCardView.setNeedsDisplay()
			}
		} else {
			if let templeCard = cell as? TempleCardCollectionViewCell {
				templeCard.templeCardView.name = Game.gameTempleArray[indexPath.row].templeName
				templeCard.templeCardView.filename = Game.gameTempleArray[indexPath.row].fileName
//				templeCard.templeCardView.cellIsSelected = indexPath.row == selectedCell
				templeCard.templeCardView.studyMode = studyMode
				templeCard.templeCardView.setNeedsDisplay()
			}
		}

		return cell
	}
	
	func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		if studyMode {
			return Game.studyTempleArray.count
		} else {
			return Game.gameTempleArray.count
		}
		
	}
	
	//MARK: collection view delegate
	
	//MARK: Collection View Select and DeSelect

	func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
		if studyMode {
			return
		}
		
		

		
		
		if selectedTableCell >= 0 {
			selectImage(indexPath)
			print("SelectedCell is: \(selectedCell), imageTempleName is: \(selectedImageName)")
			
			//Match against image name
			print("selectedTableName is: \(selectedTableName), selectedTableCell is: \(selectedTableCell)")
			
			let isMatch = Game.match(selectedImageName, templeTable: selectedTableName)
			
			if isMatch {
				correctScore.title = "Correct: \(Game.correct)"
				matched()


				
				print("Matched! tableTempleName: \(selectedTableName), imageTempleName: \(selectedImageName), correct: \(Game.correct), incorrect: \(Game.incorrect)")
				
			} else {
				incorrectScore.title = "Incorrect: \(Game.incorrect)"
				notMatched()


				print("Not Matched! tableTempleName: \(selectedTableName), imageTempleName: \(selectedImageName), correct: \(Game.correct), incorrect: \(Game.incorrect)")
			}
			

		} else {
			UIView.animateWithDuration(0.25, delay: 0, options: .CurveEaseInOut, animations: {
				
				self.selectImageView(indexPath)
				
			}, completion: nil)
			
//			print("COLLECTIONVIEW/ selectedCell: \(selectedCell), selectedTempleImage: \(selectedImageName), selectedTableCell: \(selectedTableCell), selectedTableCellName: \(selectedTableName)")
		}
	}
	

	//MARK: collection view delegate flow layout
	
	func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
		var cellImage: UIImage!
		var width: CGFloat!
		
		if studyMode {
			cellImage = UIImage(named: Game.studyTempleArray[indexPath.row].fileName)
		} else {
			cellImage = UIImage(named: Game.gameTempleArray[indexPath.row].fileName)
		}

		let actualHeight = cellImage.size.height
		let actualWidth = cellImage.size.width
		
		width = CGFloat(COLLECTION_CELL_HEIGHT * (actualWidth / actualHeight))
	
		
		let CG = CGSizeMake(width, COLLECTION_CELL_HEIGHT)
		
		return CG
		
//		return CGSizeMake(CGFloat(indexPath.row % 3 * 10 + 120), 100)
		
		// w 960 h 640
		// w 960 h 633
		
		// ah = 100
		// aw = 100 * 960 / 640
		
		// h/w = ah/aw
	}

//########################################## TABLE VIEW ###########################################	
	//MARK: Table view data source
	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCellWithIdentifier("TempleNameCell")!
		
		cell.textLabel?.text = Game.tableTempleArray[indexPath.row].templeName
		return cell
	}
	
	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return Game.tableTempleArray.count
	}
	
	//MARK: Table view delegate
	func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
		//Set name and row
		selectedTableCell = indexPath.row
		
		if let cell = tableView.cellForRowAtIndexPath(indexPath) {
			selectedTableName = cell.textLabel!.text!
		}
		
		if selectedCell >= 0 {
			//get selectedCell and match against it
			
			let isMatch = Game.match(selectedImageName, templeTable: selectedTableName)
		
			if isMatch {
				correctScore.title = "Correct: \(Game.correct)"
				matched()
			
				print("Matched! selectedImageName: \(selectedImageName), imageTempleName: \(selectedTableName), correct: \(Game.correct), incorrect: \(Game.incorrect)")
				
			} else {
				incorrectScore.title = "Incorrect: \(Game.incorrect)"


				notMatched()

				print("Not Matched! selectedImageName: \(selectedImageName), imageTempleName: \(selectedTableName), correct: \(Game.correct), incorrect: \(Game.incorrect)")
			}
		}
		

		
		print("selectedTableName is: \(selectedTableName), selectedTableCell is: \(selectedTableCell)")
//		print("TABLEVIEW/ selectedCell: \(selectedCell), selectedTempleImage: \(selectedImageName), selectedTableCell: \(selectedTableCell), selectedTableCellName: \(selectedTableName)")
	}
	

	


//########################################## TOOL BAR ACTIONS ###########################################
	//MARK: Tool Bar Outlets
	@IBOutlet weak var correctScore: UIBarButtonItem!
	@IBOutlet weak var incorrectScore: UIBarButtonItem!
	
	// MARK: Actions
	@IBAction func toggleMode(sender: UIBarButtonItem) {
		self.view.layoutIfNeeded() //clean slates animations. terminate animations
		studyMode = !studyMode
		
		borderViewWidthConstraint.constant = studyMode ? 0 : 200
		collectionView.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, 0, studyMode ? 0 :200)
		if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
			layout.sectionInset.right = studyMode ? 4 : 204
		}
		
		
		UIView.animateWithDuration(0.5, delay: 0, options: .CurveEaseInOut, animations: {
			sender.title = self.studyMode ? "Match" : "Study"
			self.collectionView.reloadData()
			self.view.layoutIfNeeded()
			}, completion: nil)
		
		correctScore.title = studyMode ? "" : "Correct:"
		incorrectScore.title = studyMode ? "" : "Incorrect:"
	}

	@IBAction func newGame(sender: UIBarButtonItem) {
		setUpGame()

		
	}
	
	


	
	func animateShake(view: UIView) {
		let animation = CAKeyframeAnimation(keyPath: "transform")
		
		animation.values = [
			NSValue(CATransform3D: CATransform3DMakeTranslation(-8, 0, 0)),
			NSValue(CATransform3D: CATransform3DMakeTranslation(8, 0, 0))]
		
		animation.autoreverses = true
		animation.repeatCount = 4
		animation.duration = 0.06
		
		view.layer.addAnimation(animation, forKey: nil)
	}
	
//########################################## HELPER FUNCTIONS ###########################################
	func resetMatchVariables() {
		selectedCell = -1
		selectedImageName = ""
		selectedTableCell = -1
		selectedTableName = ""
	}
	
	func setUpGame() {
		Game = GameState()
		correctScore.title = "Correct: \(Game.correct)"
		incorrectScore.title = "Incorrect: \(Game.incorrect)"
		resetMatchVariables()
		
		collectionView.reloadData()
		self.view.layoutIfNeeded()

	}
	
	func deleteIfMatched() {
		if selectedTableCell >= 0 {
			tableView.beginUpdates()
			let selectedPath = NSIndexPath(forRow: selectedTableCell, inSection: 0)
			tableView.deleteRowsAtIndexPaths([selectedPath], withRowAnimation: .Middle)
			
			Game.tableTempleArray.removeAtIndex(selectedTableCell)
			
			selectedTableCell = -1
			tableView.endUpdates()
		}
		
		if selectedCell >= 0{
			let selectedPath = NSIndexPath(forRow: selectedCell, inSection: 0)
			
			Game.gameTempleArray.removeAtIndex(selectedCell)
			selectedCell = -1
			
			collectionView.performBatchUpdates({
				self.collectionView.deleteItemsAtIndexPaths([selectedPath])
				
				for cell in self.collectionView.visibleCells() {
					if let templeCell = cell as? TempleCardCollectionViewCell {
						templeCell.templeCardView.setNeedsDisplay()
					}
				}
				}, completion: nil)
		}
	}
	
	func matched() {
		deleteIfMatched()
		audioPlayer.play()
		matchedAnimation()
		
	}
	
	func matchedAnimation() {
		UIView.animateWithDuration(1.0, animations: { () -> Void in
			self.collectionView.backgroundColor = UIColor.greenColor()
			}) { (Bool) -> Void in
				
				UIView.animateWithDuration(1.0, animations: { () -> Void in
					self.collectionView.backgroundColor = UIColor.blackColor()
					}, completion: { (Bool) -> Void in
				
						UIView.animateWithDuration(1.0, animations: { () -> Void in
							self.collectionView.backgroundColor = UIColor.greenColor()
							}, completion: { (Bool) -> Void in
						
								UIView.animateWithDuration(1.0, animations: { () -> Void in
									self.collectionView.backgroundColor = UIColor.blackColor()
									}, completion:nil)
						
						})

				})

		}

	}
	
	func notMatched() {
		animateShake(gameView)
		deselectTableCell()
		deselectImage()
		
		notMatchedAnimation()
		
	}
	
	func notMatchedAnimation() {
		let image = UIImage(named: "flames.jpg")
//		animateShake(gameView)
		
		UIView.animateWithDuration(0.5, animations: { () -> Void in
			self.collectionView.backgroundColor = UIColor(patternImage: image!)
			}) { (Bool) -> Void in
				
				UIView.animateWithDuration(0.5, animations: { () -> Void in
					self.collectionView.backgroundColor = UIColor.blackColor()
					}, completion: { (Bool) -> Void in
						
						UIView.animateWithDuration(0.5, animations: { () -> Void in
							self.collectionView.backgroundColor = UIColor(patternImage: image!)
							}, completion: { (Bool) -> Void in
								
								UIView.animateWithDuration(0.5, animations: { () -> Void in
									self.collectionView.backgroundColor = UIColor.blackColor()
									}, completion:nil)
								
						})
						
				})
				
		}
	}
	
	//Changes how an image which is selected looks
	func selectImageView(indexPath: NSIndexPath) {
		let selectedPath = NSIndexPath(forRow: self.selectedCell, inSection: 0)
		
		if let selectedTempleCell = self.collectionView.cellForItemAtIndexPath(selectedPath) as? TempleCardCollectionViewCell {
			//					print("Hello underworld!")
//			selectedTempleCell.templeCardView.cellIsSelected = false
//			selectedTempleCell.templeCardView.setNeedsDisplay()
			selectedTempleCell.alpha = 1
			self.selectedCell = -1
		}
		
		if selectedPath.row != indexPath.row {
			if let templeCell = collectionView.cellForItemAtIndexPath(indexPath) as? TempleCardCollectionViewCell {
				selectImage(indexPath)
				
//				self.selectedCell = indexPath.row
//				self.selectedImageName = templeCell.templeCardView.name
//				templeCell.templeCardView.cellIsSelected = true
				templeCell.templeCardView.setNeedsDisplay()
				templeCell.alpha = 0.5
			}
		}
		
//		selectImage(indexPath)
	}
	
	func selectImage(indexPath: NSIndexPath) {
		if let templeCell = collectionView.cellForItemAtIndexPath(indexPath) as? TempleCardCollectionViewCell {
			selectedCell = indexPath.row
			selectedImageName = templeCell.templeCardView.name
			selectedImageCell = collectionView.cellForItemAtIndexPath(indexPath) as? TempleCardCollectionViewCell
		}
	}
	
	func deselectImage() {
			selectedCell = -1
			selectedImageName = ""
			selectedImageCell.setNeedsDisplay()
			selectedImageCell.alpha = 1
	}
	
	func deselectTableCell() {
		//Deselect Table Cell
		let tablePath = NSIndexPath(forRow: selectedTableCell, inSection: 0)
		[tableView .deselectRowAtIndexPath(tablePath, animated: true)]
		
		//Reset Table Variables
		selectedTableCell = -1
		selectedTableName = ""
	}
	

	
	

	
}

//########################################## NOTES ###########################################
//		THIS CODE IS FROM DR LIDDLE'S VIDEO DEMO ON SELECTING FOR COLLECTION VIEW
//		if let selectedTempleCell = collectionView.cellForItemAtIndexPath(selectedPath) as? TempleCardCollectionViewCell {
//			selectedTempleCell.templeCardView.cellIsSelected = false
//			selectedTempleCell.templeCardView.setNeedsDisplay()
//			selectedCell = -1
//		}
//
//
//		if selectedPath.row != indexPath.row {
//			if let templeCell = collectionView.cellForItemAtIndexPath(indexPath) as? TempleCardCollectionViewCell {
//				selectedCell = indexPath.row
//				templeCell.templeCardView.cellIsSelected = true
//				templeCell.templeCardView.setNeedsDisplay()
//			}
//		}

//UIView.transitionwithduration
//cwstatusbarnotification

//				let tablePath = NSIndexPath(forRow: selectedTableCell, inSection: 0)
//				[tableView .deselectRowAtIndexPath(tablePath, animated: true)]		//deselects