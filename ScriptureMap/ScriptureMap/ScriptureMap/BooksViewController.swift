//
//  BooksViewController.swift
//  ScriptureMap
//
//  Created by Nathan Crowther on 11/10/15.
//  Copyright © 2015 Nathan Crowther. All rights reserved.
//

import UIKit

class BooksViewController: UITableViewController {
	// MARK: - Constants
	
	let BOOK_CELL = "BookCell"
	let SEGUE_SHOW_CHAPTERS = "Show Chapters"
	let SEGUE_SHOW_TEXT = "Show Scripture"
	
	// MARK: Properties
	
	var books: [Book]!

	
	//MARK: - Table view data source
	override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCellWithIdentifier("BookCell")!
		
		cell.textLabel?.text = books[indexPath.row].fullName
		
		return cell
	}
	
	override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return books.count
	}
	
	// MARK: - Table view delegate
	
	override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
		let book = books[indexPath.row]
		
		if book.numChapters != nil && book.numChapters > 0 {
			performSegueWithIdentifier(SEGUE_SHOW_CHAPTERS, sender: self)
		} else {
			performSegueWithIdentifier(SEGUE_SHOW_TEXT, sender: self)
		}
	}
	
	// MARK: - Segues
	
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		if segue.identifier == SEGUE_SHOW_CHAPTERS {
			if let indexPath = self.tableView.indexPathForSelectedRow {
				let destVC = segue.destinationViewController as! ChapterViewController
				
				destVC.book = books[indexPath.row]
				destVC.title = books[indexPath.row].tocName
			}
		} else if segue.identifier == SEGUE_SHOW_TEXT {
			if let indexPath = self.tableView.indexPathForSelectedRow {
				let destVC = segue.destinationViewController as! ScriptureViewController
				
				destVC.book = books[indexPath.row]
				destVC.chapter = 0
				destVC.title = books[indexPath.row].backName
			}
		}
	}
	
	
//	// MARK: Table view delegate
//	override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//		if books[indexPath.row].numChapters > 1 {
//			performSegueWithIdentifier("Show Chapters", sender: self)
//		} else {
//			performSegueWithIdentifier("Show Scripture", sender: self)
//		}
//		
//		
//	}
//	
//	// MARK: Segues
//	
//	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//		
//		if let indexPath1 = tableView.indexPathForSelectedRow {
//
//			if let book = books[indexPath1.row] as? Book {
//				print("indexPath1.row is \(indexPath1.row)")
//				print("book at indexPath1.row is \(book.fullName)")
//				print("book.id is \(book.id)")
//				
//				
//				
//				if book.numChapters > 1 {
//					if segue.identifier == "Show Chapters" {
//						if let indexPath = tableView.indexPathForSelectedRow {
//							if let destVC = segue.destinationViewController as? ChapterViewController {
//								destVC.numChapters = book.numChapters!
//								destVC.book = book
//							}
//						}
//					}
//				} else { //if book.numChapters == nil
//					if segue.identifier == "Show Scripture" {
//						if let indexPath = tableView.indexPathForSelectedRow {
//							if let destVC = segue.destinationViewController as? ScriptureViewController {
//								destVC.book = book
//								print("\(book.fullName) has \(book.numChapters) Chapters!")
//								print("\(book.fullName) subdiv is \(book.subdiv)")
//								
//								if book.numChapters != nil {
//									destVC.chapter = 1
//								}
//								
//							}
//						}
//					}
//				}
//				
//				
//			}
//			
////			if books[indexPath1.row].numChapters > 1 {
////				if segue.identifier == "Show Chapters" {
////					if let indexPath = tableView.indexPathForSelectedRow {
////						if let destVC = segue.destinationViewController as? ChapterViewController {
////							destVC.numChapters = books[indexPath.row].numChapters!
////							destVC.book = books[indexPath.row]
////							print("(SHOW CHAPTERS) book at indexPath.row is: \(destVC.book.fullName)")
////						}
////					}
////				}
////			} else if books[indexPath1.row].numChapters == 1{
////				print("HERE")
////				if segue.identifier == "Show Scripture" {
////					if let indexPath = tableView.indexPathForSelectedRow {
////						if let destVC = segue.destinationViewController as? ScriptureViewController {
////							destVC.book = books[indexPath.row]
////							print("(SHOW SCRIPTURE) book at indexPath.row is: \(destVC.book.fullName)")
////							destVC.chapter = 1
////							//					destVC.title = book.fullName
////						}
////					}
////				}
////
////			}
//		}
//		else {
//			print("Didnt' work!")
//		}
//
//		
//		
//	}
	

}

//			print("Got here1")
//			if segue.identifier == "Show Scripture" {
//				print("Got here2")
//				if let indexPath = tableView.indexPathForSelectedRow {
//					print("Got here3")
//					if let destVC = segue.destinationViewController as? ScriptureViewController {
//
//
//						destVC.book = books[indexPath.row]
//						print("book at indexPath.row is: \(destVC.book.fullName)")
//						destVC.chapter = 1
//					}
//				}
//			}
