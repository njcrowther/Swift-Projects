//
//  NewMapViewController.swift
//  ScriptureMap
//
//  Created by Nathan Crowther on 11/9/15.
//  Copyright © 2015 Nathan Crowther. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
	//MARK: Properties
	var annotationTitle: String!
	var localGeocodes: [GeoPlace]!

	let locationManager = CLLocationManager()
	var selectedPlace: String!
	
	//MARK: outlets
	@IBOutlet weak var mapView: MKMapView!
	
	//MARK: View controller lifecycle
	override func viewDidAppear(animated: Bool) {
		super.viewDidAppear(animated)

		//MARK: User Location
		
//		if localGeocodes == nil {
//			//MARK: Location Authorization
//			self.locationManager.requestAlwaysAuthorization()
//			
//			//MARK: for use in foreground
//			self.locationManager.requestWhenInUseAuthorization()
//			
//			if CLLocationManager.locationServicesEnabled() {
//				locationManager.delegate = self
//				locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
//				locationManager.startUpdatingLocation()
//			}
//		}
		
		if let localCodes = localGeocodes {
			print("(viewDidAppear)localGeocodes size is \(localGeocodes.count)")
			
			let annotations = makeAnnotations(localCodes)
			zoomToRegion(annotations)
			dropPins(annotations)
		} else {
			print("(viewDidAppear)localGeocodes size is nil")
		}

	}
	
	func getSelectedPlace(geoPlaceID: String) -> GeoPlace {
		
		let returnPlace = GeoDatabase.sharedGeoDatabase.geoPlaceForId(Int(geoPlaceID)!)
		
		return returnPlace!
	}
	
	func makeAnnotations(geoPlaces: [GeoPlace]!) -> [MKPointAnnotation] {
		var annotations: [MKPointAnnotation] = []
		
		if geoPlaces != nil {
			print("(makeAnnotations) geoPlaces size is \(geoPlaces.count)")
		}
		
		for geoPlace in geoPlaces {
			let annotation1 = MKPointAnnotation()
			
			print("(makeAnnotations) geoPlace title: \(geoPlace.placename) latitude: \(geoPlace.latitude) longitude: \(geoPlace.longitude)")
			
			let latitude = CLLocationDegrees(geoPlace.latitude)
			let longitude = CLLocationDegrees(geoPlace.longitude)
			annotation1.coordinate = CLLocationCoordinate2DMake(latitude, longitude)
			annotation1.title = geoPlace.placename

			annotations.append(annotation1)
			
			

			
			
			
			

		}
		
		return annotations
	}
	
	
	
	func dropPins(annotations: [MKPointAnnotation]!) {
		if annotations != nil {
			mapView.showsUserLocation = false
			locationManager.stopUpdatingLocation()
			

			dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(2 * Double(NSEC_PER_SEC))), dispatch_get_main_queue(), {
				
				for annotation in annotations {
					self.mapView.addAnnotation(annotation)
				}
			})
		}

	}
	
	
	func zoomToRegion(annotations: [MKPointAnnotation]!) {
		if let annotationArray = annotations {
			let centerPoint = findCenter(annotationArray)
			
			let region = MKCoordinateRegion(center: centerPoint, span: MKCoordinateSpan(latitudeDelta: 4, longitudeDelta: 4))
			
			self.mapView.setRegion(region, animated: true)
		}
	}
	
	
	func zoomToPoint(annotations: [MKPointAnnotation]) {
		print("(zoomToPoint)")
		
		if let geoplace = GeoDatabase.sharedGeoDatabase.geoPlaceForId(Int(selectedPlace)!) {
			let coordinate = CLLocationCoordinate2DMake(geoplace.latitude, geoplace.longitude)
			
			let camera = MKMapCamera(lookingAtCenterCoordinate: coordinate, fromEyeCoordinate: coordinate, eyeAltitude: 300)
			
			mapView.setCamera(camera, animated: true)
		}
		
	}
	
	
	
	func findCenter(annotations: [MKPointAnnotation]) -> CLLocationCoordinate2D {
		var latitudeSum: CLLocationDegrees
		latitudeSum = 0
		var longitudeSum: CLLocationDegrees
		longitudeSum = 0
		var latitudeCount = 0
		var longitudeCount = 0
		
		for annotation in annotations {
			latitudeSum += annotation.coordinate.latitude
			longitudeSum += annotation.coordinate.longitude
			latitudeCount++
			longitudeCount++
		}
		
		if latitudeSum == 0 || longitudeSum == 0 {
			return CLLocationCoordinate2DMake(40.2506, -111.65247)
		}
		
		let latitudeAverage = Int(latitudeSum) / latitudeCount
		let longitudeAverage = Int(longitudeSum) / longitudeCount
		
		return CLLocationCoordinate2DMake(CLLocationDegrees(latitudeAverage), CLLocationDegrees(longitudeAverage))
	}
	
	
	
	func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//		let locValue:CLLocationCoordinate2D = (manager.location?.coordinate)!
		let location = locations.last! as CLLocation
		
		let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.latitude)
		let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
		
		let camera = MKMapCamera(lookingAtCenterCoordinate: location.coordinate, fromEyeCoordinate: location.coordinate, eyeAltitude: 300)
		mapView.setCamera(camera, animated: true)
		mapView.setRegion(region, animated: true)
		mapView.showsUserLocation = true
		
//		print("latitude: \(location.coordinate.latitude) longitude: \(location.coordinate.latitude)")
		
		
	}


	func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
		let view = 	mapView.dequeueReusableAnnotationViewWithIdentifier("Pin")
		
		if view == nil {
			let pinView = MKPinAnnotationView()
			
			pinView.animatesDrop = true
			pinView.canShowCallout = true
			pinView.pinTintColor = MKPinAnnotationView.purplePinColor()
		} else {
			view?.annotation = annotation
		}
		
		return view
	}


}

