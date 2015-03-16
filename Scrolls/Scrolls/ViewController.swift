//
//  ViewController.swift
//  Scrolls
//
//  Created by Bobby Towers on 3/10/15.
//  Copyright (c) 2015 Bobby Towers. All rights reserved.
//

import UIKit

// UIScrollViewDelegate to allow zooming and panning to work
class ViewController: UIViewController, UIScrollViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
/*
        // 10 columns
        let columns = 10
        
        // Horizontal scroll view
        var hScrollView = UIScrollView(frame: self.view.frame)
        
        // This sets the scroll area (what can be scrolled)
        hScrollView.contentSize = CGSizeMake(CGFloat(columns) * self.view.frame.width, self.view.frame.height)
        // This snaps it horizontally
//        hScrollView.pagingEnabled = true
        
        for c in 0..<columns {
            
            // Randomized rows for scroll views
            let rows = arc4random_uniform(3) + 2
            
            // Vertical scroll view
            var vScrollView = UIScrollView(frame: self.view.frame)
            
            vScrollView.frame.origin.x = CGFloat(c) * self.view.frame.width
            
            // This sets the scroll area for the vertical scroll views
            vScrollView.contentSize = CGSizeMake(self.view.frame.width, CGFloat(rows) * self.view.frame.height)
            // This snaps it vertically
//            vScrollView.pagingEnabled = true
            
            for r in 0..<rows {
                
                // Individual views on each vertical scroll views
                var view = UIView(frame: self.view.frame)
                view.frame.origin.y = CGFloat(r) * self.view.frame.height
                
                // Grey, black, and white cells
//                let grey = CGFloat(arc4random_uniform(100)) / 100
//                view.backgroundColor = UIColor(white: grey, alpha: 1.0)
                
                // Rainbow cells
                let red = CGFloat(arc4random_uniform(100)) / 100
                let green = CGFloat(arc4random_uniform(100)) / 100
                let blue = CGFloat(arc4random_uniform(100)) / 100
                view.backgroundColor = UIColor(red: red, green: green, blue: blue, alpha: 1.0)
                
                vScrollView.addSubview(view)
            }
            vScrollView.bounces = false
            hScrollView.addSubview(vScrollView)
        }
        hScrollView.bounces = false
        self.view.addSubview(hScrollView)
*/
        
        // Adding an image scroll view
        var imageScrollView = UIScrollView(frame: view.frame)
        var image = UIImage(named: "RainbowQuilt")
        imageView = UIImageView(image: image)
        
        imageScrollView.delegate = self
        
        imageScrollView.addSubview(imageView)
//        imageScrollView.contentSize = imageView.frame.size
        imageScrollView.contentSize = CGSize(width: imageView.frame.width, height: 200)
        imageScrollView.bounces = false // goes to the edge and stops
//        imageScrollView.minimumZoomScale = 0.1
//        imageScrollView.maximumZoomScale = 2.0
        imageScrollView.setZoomScale(1.0, animated: true)
        
        self.view.addSubview(imageScrollView)
    }
    
    // making our image view global
    var imageView: UIImageView!

    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        
        return imageView
    }
    
    func scrollViewDidEndZooming(scrollView: UIScrollView, withView view: UIView!, atScale scale: CGFloat) {
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

