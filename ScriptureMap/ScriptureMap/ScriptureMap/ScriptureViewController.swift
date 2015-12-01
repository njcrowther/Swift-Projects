//
//  ScriptureViewController.swift
//  ScriptureMap
//
//  Created by Nathan Crowther on 11/10/15.
//  Copyright © 2015 Nathan Crowther. All rights reserved.
//

import UIKit

class ScriptureViewController : UIViewController, UIWebViewDelegate {
	//MARK: Constants
	let LINK_PREFIX = "http://scriptures.byu.edu/mapscrip/"
	let PATH_DELIMITER = "/"
	let SEGUE_SHOW_MAP = "Show Map"
	
	//MARK: Properties
	var book: Book!
	var chapter = 0
//	var scriptureRenderer: ScriptureRenderer!
//	var geoPlaceArray: [GeoPlace]!
	
	weak var mapViewController: NewMapViewController?
	var mapConfiguration: MapConfiguration?
	
	//MARK: Outlets
	@IBOutlet weak var webView: UIWebView!
	
	//MARK: View controller Lifecycle
	
	override func viewDidLoad() {
		super.viewDidLoad()
		configureDetailViewController()

//		print("book id is \(book.id). chapter is \(chapter). Book is \(book.fullName). Book has \(book.numChapters) Chapters")
		
		let html = ScriptureRenderer.sharedRenderer.htmlForBookId(book.id, chapter: chapter)

//		geoPlaceArray = ScriptureRenderer.sharedRenderer.collectedGeocodedPlaces
		
//		print("geoPlaces size is: \(geoPlaceArray.count)")
		

		//load this HTML into the web view
		webView.loadHTMLString(html, baseURL: nil)

		mapConfiguration = MapConfiguration()
		
		if let detailVC = mapViewController {
			detailVC.configuration = mapConfiguration!
		}
		
		
		//Display geoPlaces
//		if geoPlaceArray != nil {
//			let annotations = mapViewController?.makeAnnotations()
//			mapViewController?.zoomToPoint(annotations!)
//			mapViewController?.dropPins(annotations!)
//		}
		
	}
	
	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		
		configureDetailViewController()
	}
	
	//MARK: Web View Delegate
	func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
		
		//URL handling to load into mapview instead of webview
		if let path = request.URL?.absoluteString {
			if path.hasPrefix(LINK_PREFIX) {
				let index = path.startIndex.advancedBy(LINK_PREFIX.lengthOfBytesUsingEncoding(NSUTF8StringEncoding))
//				let geoplaceID = path.substringFromIndex(index)
				let geoplaceId = Int(path.substringFromIndex(index))
				
				
				mapConfiguration?.adjustCameraToGeoPlace(geoplaceId!)
				
				if let detailVC = mapViewController {
					// If the map is already visible, we just need to configure it appropriately
					detailVC.configureMap()
				} else {
					// But if it's not visible, we need to segue to it
					performSegueWithIdentifier(SEGUE_SHOW_MAP, sender: self)
				}
				
				return false
				
				
//				if mapViewController == nil {
//					
//					mapViewController?.selectedPlace = geoplaceID
//					performSegueWithIdentifier("Show Map", sender: self)
//					
//				} else {
//					print("You have a map view controller")
//					//NEEDSWORK: adjust map to show requested geoplace
//
//					mapViewController?.selectedPlace = geoplaceID
//					
////					print("(shouldStartLoadWithRequest) localGeocodes size is: \(geoPlaceArray.count)")
//					
//
//
//					
//				}
//				
//
//				
//				return false
			}
		}
		
		return true
	}
	
	//MARK: Segues
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		if segue.identifier == "Show Map" {
			let navVC = segue.destinationViewController as! UINavigationController
			
			if let destVC = navVC.topViewController as? NewMapViewController {
				destVC.configuration = mapConfiguration!
				destVC.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
				destVC.navigationItem.leftItemsSupplementBackButton = true
			}
			
			
//			if let navVC = segue.destinationViewController as? UINavigationController {
//				if let mapVC = navVC.topViewController as? NewMapViewController {
//					//NEEDSWORK: configure the map view according to the requested parameters
//					
////					mapViewController?.localGeocodes = geoPlaceArray
//					
//					
//					mapVC.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem()
//					mapVC.navigationItem.leftItemsSupplementBackButton = true
//				}
//			}
		}
	}
	
	//MARK: Helpers
	func configureDetailViewController() {
		if let splitVC = splitViewController {
			mapViewController = (splitVC.viewControllers.last as! UINavigationController).topViewController as? NewMapViewController
		} else {
			mapViewController = nil
		}
	}
}
