//
//  ViewController.swift
//  LocationTracker
//
//  Created by Bobby Towers on 3/17/15.
//  Copyright (c) 2015 Bobby Towers. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    @IBOutlet weak var myMapView: MKMapView!
    @IBOutlet weak var mapLabel: UILabel!
    
    var manager: CLLocationManager!
    var myLocations: [CLLocation] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up location manager
        manager = CLLocationManager()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestAlwaysAuthorization()
        manager.startUpdatingLocation()
        
        // Set up map view
        myMapView.delegate = self
        myMapView.mapType = MKMapType.Satellite
        myMapView.showsUserLocation = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        mapLabel.text = "\(locations[0])"
        myLocations.append(locations[0] as CLLocation)
        
        let spanX = 0.007
        let spanY = 0.007
        
        var newRegion = MKCoordinateRegionMake(myMapView.userLocation.coordinate, MKCoordinateSpanMake(spanX, spanY))
        myMapView.setRegion(newRegion, animated: true)
        
        if (myLocations.count > 1) {
            
            var sourceIndex = myLocations.count - 1
            var destinationIndex = myLocations.count - 2
            
            let coordOne = myLocations[sourceIndex].coordinate
            let coordTwo = myLocations[destinationIndex].coordinate
            
            var coordArray = [coordOne, coordTwo]
            var polyline = MKPolyline(coordinates: &coordArray, count: coordArray.count)
            myMapView.addOverlay(polyline)
        }
    }
    
    func mapView(mapView: MKMapView!, rendererForOverlay overlay: MKOverlay!) -> MKOverlayRenderer! {
        
        if overlay is MKPolyline {
            var polylineRenderer = MKPolylineRenderer(overlay: overlay)
            polylineRenderer.strokeColor = UIColor.blueColor()
            polylineRenderer.lineWidth = 4
            return polylineRenderer
        }
        return nil
    }
}

