//
//  ViewController.swift
//  Maps
//
//  Created by Bobby Towers on 2/2/15.
//  Copyright (c) 2015 Bobby Towers. All rights reserved.
//

/*
Homework 2/2/15

-make the map view show your current location (not as an annotation, but as the blue dot)

-make the "annotation view" show using "title" on an annotation (make the title be the name of the venue)

-make the mapview zoom to the annotations (maybe look for a way to make a region based on the annotations)

-change the pin color
*/

import UIKit

// handles the map
import MapKit

// will handle location and where our location is
import CoreLocation

var onceToken: dispatch_once_t = 0

class ViewController: UIViewController, CLLocationManagerDelegate {

    var locationManager = CLLocationManager()
    
    var mapView = MKMapView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        var mapView = MKMapView(frame: view.frame)
        mapView.frame = view.frame
        
        
        view.addSubview(mapView)
        
        locationManager.delegate = self
        
        locationManager.startUpdatingLocation()
        
        locationManager.distanceFilter = kCLDistanceFilterNone
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        locationManager.requestWhenInUseAuthorization()
        
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        
        // we pass a pointer as a parameter, so when it changes in the method, it is changing the actual global property above at the top (onceToken)
        // dispatch_once takes whatever code and only runs it once for the lifetime of the application
        dispatch_once(&onceToken) { () -> Void in
            
            println(locations.last)
            
            
            // ? after as? is the same as putting a ? behind CLLocation?
            if let location = locations.last as CLLocation? {
                
                // 0.1 is in degrees
                let span = MKCoordinateSpanMake(0.1, 0.1)
                
//                self.mapView.centerCoordinate = location.coordinate
                let region = MKCoordinateRegion(center: location.coordinate, span: span)
                
                self.mapView.setRegion(region, animated: true)
                
                // request to foursquare for venues with location
                let venues = FourSquareRequest.requestVenuesWithLocation(location)
                
                println(venues)
                
                self.createAnnotationsWithVenues(venues)
                
            }
            
        }
        
        locationManager.stopUpdatingLocation()
        
    }
    
    func createAnnotationsWithVenues(venues: [AnyObject]) {
        
        for venue in venues as [[String:AnyObject]] {
            
            let locationInfo = venue["location"] as [String:AnyObject]
            
            let lat = locationInfo["lat"] as CLLocationDegrees
            
            let lng = locationInfo["lng"] as CLLocationDegrees
            
            let coord = CLLocationCoordinate2DMake(lat, lng)
            
            let annotation = MKPointAnnotation()
            annotation.setCoordinate(coord)
            
            mapView.addAnnotation(annotation)
            
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

        
        
    }


}

