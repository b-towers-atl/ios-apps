//
//  ViewController.swift
//  Directions
//
//  Created by Bobby Towers on 3/17/15.
//  Copyright (c) 2015 Bobby Towers. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {

    @IBOutlet weak var myMapView: MKMapView!
    
    var lManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lManager.requestWhenInUseAuthorization()
        
        myMapView.showsUserLocation = true
        
        let geoCoder = CLGeocoder()
        
        // THIS TO OPEN APPLE MAPS FOR DIRECTIONS
        
        // In the string part of this, you can put whatever address
        geoCoder.geocodeAddressString("30303", completionHandler: { (placemarks, error) -> Void in
            
            if let placemark = placemarks.last as? CLPlacemark {
                // placemark is CLPlacemark, need to convert it to MKPlacemark
                
                let mapPlacemark = MKPlacemark(placemark: placemark)
                
                // Another way to create a MKPlacemark coordinate
//                MKPlacemark(coordinate: <#CLLocationCoordinate2D#>, addressDictionary: <#[NSObject : AnyObject]!#>)
                
                // This is our destination
                let mapItem: MKMapItem = MKMapItem(placemark: mapPlacemark)
                
                // Opens in Apple Maps app
//                mapItem.openInMapsWithLaunchOptions(nil)
                
                // Can also do MKLaunchOptionsDirectionsModeWalking
                let options = [MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving]
                
                let currentMapItem: MKMapItem = MKMapItem.mapItemForCurrentLocation()
                
                MKMapItem.openMapsWithItems([currentMapItem, mapItem], launchOptions: options)
            }
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

