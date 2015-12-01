//
//  VolumesViewController.swift
//  ScriptureMap
//
//  Created by Nathan Crowther on 11/10/15.
//  Copyright © 2015 Nathan Crowther. All rights reserved.
//

import UIKit

class VolumesViewController : UITableViewController {
	
	// MARK: Properties
	
	var volumes = GeoDatabase.sharedGeoDatabase.volumes()
	
	// MARK: - Segues
	
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		if segue.identifier == "Show Books" {
			if let indexPath = self.tableView.indexPathForSelectedRow {
				if let destVC = segue.destinationViewController as? BooksViewController {
					destVC.books = GeoDatabase.sharedGeoDatabase.booksForParentId(indexPath.row + 1)
					destVC.title = volumes[indexPath.row]
				}
			}
		}
	}
	
	//MARK: - Table view data source
	override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCellWithIdentifier("VolumeCell")!
		
		cell.textLabel?.text = volumes[indexPath.row]
		
		return cell
	}
	
	override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return volumes.count
	}
	
	
}
