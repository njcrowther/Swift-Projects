//
//  NewMapViewController.swift
//  Project 4 Foundation
//
//  Created by Steve Liddle on 11/5/15.
//  Copyright © 2015 Steve Liddle. All rights reserved.
//

import UIKit
import MapKit

class NewMapViewController: UIViewController, MKMapViewDelegate {

    // MARK: - Constants

    let ANNOTATION_ID = "Pin"

    // MARK: - Properties

    var configuration: MapConfiguration? {
        didSet {
            if mapView != nil {
                setupAnnotations()
            }
        }
    }

    // MARK: - Outlets

    @IBOutlet weak var mapView: MKMapView!

    // MARK: - View controller lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if configuration == nil {
            if let split = splitViewController {
                if let scriptureVC = (split.viewControllers.first as! UINavigationController).topViewController as? ScriptureViewController {
                    // If the master VC has a scripture VC at the top of the stack, we should
                    // initialize our map configuration to the scripture VC's map configuration
                    configuration = scriptureVC.mapConfiguration
                    return
                }
            }
        }
        
        setupAnnotations()
    }
    
    // MARK: - Map view delegate
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        let view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: ANNOTATION_ID)
        
        view.canShowCallout = true
        
        return view
    }
    
    // MARK: - Actions
    
    @IBAction func resetZoom(sender: UIBarButtonItem) {
        configuration?.camera = nil
        configuration?.viewRegion = nil
        
        configureMap()
    }
    
    @IBAction func cancelSuggestGeocoding(segue: UIStoryboardSegue) {
        // Ignore
        print("Canceled suggest geocoding action")
    }
    
    @IBAction func saveSuggestedGeocoding(segue: UIStoryboardSegue) {
        // NEEDSWORK: save it
        print("Saved suggest geocoding action")
        
//        if let suggestionVC = segue.sourceViewController as? SuggestGeocodingViewController {
//            print("Text field holds the string <\(suggestionVC.textField.text)>")
//        }
    }
    
    // MARK: - Helpers
    
    func adjustCameraToParameters(parameters: [String]) {
        configuration?.adjustCameraToGeoPlace(Int(parameters[0])!)
        mapView.setCamera(configuration!.camera!, animated: true)
    }
    
    func configureMap() {
        if configuration!.camera == nil && configuration!.viewRegion == nil {
            configuration!.computeViewSettings()
        }
        
        if let camera = configuration!.camera {
            mapView.setCamera(camera, animated: true)
        } else if let region = configuration!.viewRegion {
            mapView.setRegion(region, animated: true)
        }
    }
    
    func setupAnnotations() {
        if mapView.annotations.count > 0 {
            mapView.removeAnnotations(mapView.annotations)
        }
        
        if let mapConfig = configuration {
            for geoplace in mapConfig.placemarks {
                let annotation = MKPointAnnotation()
                
                annotation.coordinate = CLLocationCoordinate2DMake(geoplace.latitude, geoplace.longitude)
                annotation.title = geoplace.placename
                annotation.subtitle = "\(geoplace.latitude), \(geoplace.longitude)"
                
                mapView.addAnnotation(annotation)
            }
        }
        
        if mapView.annotations.count > 0 {
            configureMap()
        }
    }

//    override func viewDidAppear(animated: Bool) {
//        super.viewDidAppear(animated)
//        
//        let camera = MKMapCamera(
//            lookingAtCenterCoordinate: CLLocationCoordinate2DMake(40.2506, -111.65247),
//            fromEyeCoordinate: CLLocationCoordinate2DMake(40.2406, -111.65247),
//            eyeAltitude: 300)
//
//        mapView.setCamera(camera, animated: false)
//
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(2 * Double(NSEC_PER_SEC))), dispatch_get_main_queue(), {
//            let annotation = MKPointAnnotation()
//            
//            annotation.coordinate = CLLocationCoordinate2DMake(40.2506, -111.65247)
//            annotation.title = "Tanner Building"
//            annotation.subtitle = "BYU Campus"
//            
//            self.mapView.addAnnotation(annotation)
//        })
//    }
}