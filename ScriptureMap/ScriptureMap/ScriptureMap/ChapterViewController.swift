//
//  ChapterViewController.swift
//  ScriptureMap
//
//  Created by Nathan Crowther on 11/18/15.
//  Copyright © 2015 Nathan Crowther. All rights reserved.
//

import UIKit

class ChapterViewController : UITableViewController {
	// MARK: Properties
	
	var books: [Book]!
	var book: Book!
	var numChapters = 0
	
	
	//MARK: - Table view data source
	override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCellWithIdentifier("chapterCell")!
		
		cell.textLabel?.text = "Chapter \(indexPath.row + 1)"
		
		return cell
	}
	
	override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return book.numChapters!
	}
	
	// MARK: Table view delegate
	override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
		performSegueWithIdentifier("Show Scripture", sender: self)
	}
	
	// MARK: Segues
	
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		if segue.identifier == "Show Scripture" {
			if let indexPath = tableView.indexPathForSelectedRow {
				if let destVC = segue.destinationViewController as? ScriptureViewController {
					destVC.book = book
					print("chapter is \(indexPath.row + 1)")
					destVC.chapter = indexPath.row + 1
					
				}
			}
		}
	}

}
