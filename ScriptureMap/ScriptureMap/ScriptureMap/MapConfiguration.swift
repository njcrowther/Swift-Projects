//
//  MapConfiguration.swift
//  Map Scriptures
//
//  Created by Steve Liddle on 11/13/14.
//  Copyright (c) 2014 IS 543. All rights reserved.
//

import Foundation
import SQLite
import MapKit

class MapConfiguration {
    
    // MARK: - Constants

    let MAX_LATLON = 180.0
    let MIN_LATLON = -180.0

    // MARK: - Properties
    
    var placemarks: [GeoPlace]
    var camera: MKMapCamera?
    var viewRegion: MKCoordinateRegion?
    
    // MARK: - Initialization
    
    init() {
        placemarks = [GeoPlace]()
        
        for geoplace in ScriptureRenderer.sharedRenderer.collectedGeocodedPlaces {
            addPlacemark(geoplace)
        }
        
        computeViewSettings()
    }
    
    // MARK: - Helpers
    
    func addPlacemark(geoplace: GeoPlace) {
        for placemark in placemarks {
            if geoplace.placename == placemark.placename &&
                geoplace.latitude == placemark.latitude &&
                geoplace.longitude == placemark.longitude {
                    // Avoid adding the same placemark twice
                    return
            }
        }
        
        placemarks.append(geoplace)
    }
    
    func adjustCameraToGeoPlace(geoplaceId: Int) {
        let geoplace = GeoDatabase.sharedGeoDatabase.geoPlaceForId(geoplaceId)

        camera = MKMapCamera(
            lookingAtCenterCoordinate: CLLocationCoordinate2DMake((geoplace?.latitude)!, (geoplace?.longitude)!),
            fromEyeCoordinate: CLLocationCoordinate2DMake((geoplace?.viewLatitude)!, (geoplace?.viewLongitude)!),
            eyeAltitude: (geoplace?.viewAltitude)!)
        camera?.pitch = CGFloat((geoplace?.viewTilt!)!)
        camera?.heading = (geoplace?.viewHeading!)!
        
        viewRegion = nil
    }
    
    func computeViewSettings() {
        if placemarks.count > 0 {
            if placemarks.count == 1 {
                let placemark = placemarks.first!
                
                camera = MKMapCamera(lookingAtCenterCoordinate: CLLocationCoordinate2DMake(placemark.latitude, placemark.longitude), fromEyeCoordinate: CLLocationCoordinate2DMake(placemark.viewLatitude!, placemark.viewLongitude!),
                    eyeAltitude: placemark.viewAltitude!)
                camera?.pitch = CGFloat(placemark.viewTilt!)
                camera?.heading = placemark.viewHeading!
                
                viewRegion = nil
            } else {
                var minLatitude = MAX_LATLON
                var minLongitude = MAX_LATLON
                var maxLatitude = MIN_LATLON
                var maxLongitude = MIN_LATLON
                
                for placemark in placemarks {
                    if placemark.latitude < minLatitude { minLatitude = placemark.latitude }
                    if placemark.latitude > maxLatitude { maxLatitude = placemark.latitude }
                    if placemark.longitude < minLongitude { minLongitude = placemark.longitude }
                    if placemark.longitude > maxLongitude { maxLongitude = placemark.longitude }
                }
                
                let center = CLLocationCoordinate2D( latitude: (minLatitude + maxLatitude) / 2,
                    longitude: (minLongitude + maxLongitude) / 2 )
                let span = MKCoordinateSpanMake( (maxLatitude - minLatitude) * 2,
                    (maxLongitude - minLongitude) * 2 )
                
                viewRegion = MKCoordinateRegion(center: center, span: span)
                camera = nil
            }
        }
    }
}