//
//  ViewController.swift
//  Maps
//
//  Created by Bobby Towers on 2/2/15.
//  Copyright (c) 2015 Bobby Towers. All rights reserved.
//

/*
Homework 2/2/15

+1. make the map view show your current location (not as an annotation, but as the blue dot)

+2. make the "annotation view" show using "title" on an annotation (make the title be the name of the venue)

+3. make the mapview zoom to the annotations (maybe look for a way to make a region based on the annotations)

+4. change the pin color
*/

import UIKit

// handles the map
import MapKit

// will handle location and where our location is
import CoreLocation

var onceToken: dispatch_once_t = 0

class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    var locationManager = CLLocationManager()
    
    var mapView = MKMapView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        
//        var mapView = MKMapView(frame: view.frame)
        mapView.frame = view.frame
        
        // #1
        mapView.showsUserLocation = true
        
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
                
                
                // objective-c way, #3
//                [mapView showAnnotations:yourAnnotationArray animated:YES];
//                yourAnnotationArray = mapView.annotations;
                
                var annotationsArray = self.mapView.annotations
                self.mapView.showAnnotations(annotationsArray, animated: true)
                
            }
            
        }
        
        locationManager.stopUpdatingLocation()
        
    }
    
    func createAnnotationsWithVenues(venues: [AnyObject]) {
        
        for venue in venues as [[String:AnyObject]] {
            
            let locationName = venue["name"] as String
            
            let locationInfo = venue["location"] as [String:AnyObject]
            
            let lat = locationInfo["lat"] as CLLocationDegrees
            
            let lng = locationInfo["lng"] as CLLocationDegrees
            
            let coord = CLLocationCoordinate2DMake(lat, lng)
            
            let annotation = MKPointAnnotation()
            annotation.setCoordinate(coord)
            
            // #2
            mapView.addAnnotation(annotation)
            annotation.title = locationName
            
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

        
        
    }
    
    // #3
    func mapView(_mapView: MKMapView!,
        viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView! {
            
            if annotation is MKUserLocation {
                //return nil so map view draws "blue dot" for standard user location
                return nil
            }
            
            let reuseId = "pin"
            
            var pinView = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseId) as? MKPinAnnotationView
            if pinView == nil {
                pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
                pinView!.canShowCallout = true
                pinView!.animatesDrop = true
                pinView!.pinColor = .Green
            }
            else {
                pinView!.annotation = annotation
            }
            
            return pinView
    }


}

