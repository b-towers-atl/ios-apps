//
//  ViewController.swift
//  adPractice
//
//  Created by Bobby Towers on 3/4/15.
//  Copyright (c) 2015 Bobby Towers. All rights reserved.
//

import UIKit
import iAd

func adBannerRect() -> ADBannerView {
    
    var adBannerRect = ADBannerView(adType: ADAdType.Banner)
    
    adBannerRect.frame = CGRectMake(0, 0, UIScreen.mainScreen().bounds.size.width, 66)
    
    return adBannerRect
}

class ViewController: UIViewController {

    @IBOutlet weak var adBanner: ADBannerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        var addBanner = ADBannerView(adType: ADAdType.Banner)
        
        // height is 66 for iPads, but is limited to 50 on iPhones
        // both will have size
        addBanner.frame = CGRectMake(0, 0, UIScreen.mainScreen().bounds.size.width, 66)
        
//        view.addSubview(addBanner)
        
        view.addSubview(adBannerRect())
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

