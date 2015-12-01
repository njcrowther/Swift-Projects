//
//  AppDelegate.swift
//  ScriptureMap
//
//  Created by Nathan Crowther on 11/9/15.
//  Copyright © 2015 Nathan Crowther. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UISplitViewControllerDelegate {
	//MARK: Properties
	var window: UIWindow?

	// MARK: Application lifecycle
	func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
		// Override point for customization after application launch.
		let splitViewController = self.window!.rootViewController as! UISplitViewController
		let navigationController = splitViewController.viewControllers.last as! UINavigationController
		navigationController.topViewController!.navigationItem.leftBarButtonItem = splitViewController.displayModeButtonItem()
		splitViewController.delegate = self
		return true
	}

	// MARK: - Split view

	func splitViewController(splitViewController: UISplitViewController, collapseSecondaryViewController secondaryViewController:UIViewController, ontoPrimaryViewController primaryViewController:UIViewController) -> Bool {
		
	    guard let secondaryAsNavController = secondaryViewController as? UINavigationController else { return false }
	    guard let _ = secondaryAsNavController.topViewController as? NewMapViewController else { return false }
		
		// Return true to indicate that we have handled the collapse by doing nothing; the secondary controller will be discarded.
		return true


	}
	
	func splitViewController(splitViewController: UISplitViewController, separateSecondaryViewControllerFromPrimaryViewController primaryViewController: UIViewController) -> UIViewController? {
		/*
			This delegate method is called when we're moving from collapsed mode back into side-by-side mode for master dan detail VCs. When our master VC is a nav VC with a stack of different VCs, the default split VC behavior is to take the top-most VC and make it the detail VC in side-by-side mode. The reason it does this is because in collapsed iPHone mode, the split VC pushes the detail VC onto the same master nav VC (since there's only room on the iPhone screen for one VC, not two side-by-side). We don't want this default separation behavior because it might put the scriptures VC in the detail side, for example. This only shows up on the iPhone 6+ when rotating from portrtait (collapsed) back to landscape (side-by-side). Bottom line: we always want the map VC to show up in the detail side. So we override this method and provide the code to (1) find the map VC in the master nav VC, or (2) instantiate a new map VC from the storyboard
		*/
		
		if let navVC = primaryViewController as? UINavigationController {
			for controller in navVC.viewControllers {
				if let controllerVC = controller as? UINavigationController {
					//We found our detail VC on the master nav VC stack
					return controllerVC
				}
			}
		}
		
		//We didn't find our detail VC on the master nav VC stack, so we need to instantiate it.
		let storyboard = UIStoryboard(name: "Main", bundle: nil)
		let detailView = storyboard.instantiateViewControllerWithIdentifier("detailVC") as! UINavigationController
		
		// Ensure back button is enabled
		if let controller = detailView.visibleViewController {
			controller.navigationItem.leftBarButtonItem = splitViewController.displayModeButtonItem()
			controller.navigationItem.leftItemsSupplementBackButton = true
		}
		
		return detailView
	}

}

