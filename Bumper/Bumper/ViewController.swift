//
//  ViewController.swift
//  Bumper
//
//  Created by Bobby Towers on 2/10/15.
//  Copyright (c) 2015 Bobby Towers. All rights reserved.
//

import UIKit
import MultipeerConnectivity

class BallView: UIView {
    
    var displayName: String!
    
}

class ViewController: UIViewController, MCSessionDelegate, MCNearbyServiceBrowserDelegate {

    var session: MCSession!
    var myPeerID: MCPeerID! // declaration type
    var browser: MCNearbyServiceBrowser!
    
    var allBallViews: [BallView] = []
    
    let serviceType = "b2"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myPeerID = MCPeerID(displayName: "Room") // method to create an instance object of MCPeerID
        
        session = MCSession(peer: myPeerID)
        session.delegate = self
        
        browser = MCNearbyServiceBrowser(peer: myPeerID, serviceType: serviceType)
        browser.delegate = self
        
        browser.startBrowsingForPeers()
    }
    
    func browser(browser: MCNearbyServiceBrowser!, foundPeer peerID: MCPeerID!, withDiscoveryInfo info: [NSObject : AnyObject]!) {
        
        println("found \(peerID)")
        
        browser.invitePeer(peerID, toSession: session, withContext: nil, timeout: 10)
        

        
        
        if let size = info?["size"] as? String {
            
            let s = CGFloat(size.toInt()!)
            
            if s > 50 { return }
            
            var ballView = BallView(frame: CGRectMake(0, 0, s, s))
            
            ballView.displayName = peerID.displayName
            ballView.layer.cornerRadius = s / 2
            ballView.center = view.center
            
            allBallViews.append(ballView)
            
            view.addSubview(ballView)
            
            if let colorR = info?["colorR"] as? NSString {
                
                let r = CGFloat(colorR.floatValue)
                let g = CGFloat((info!["colorB"] as NSString).floatValue)
                let b = CGFloat((info!["colorG"] as NSString).floatValue)
                
                ballView.backgroundColor = UIColor(red: r, green: g, blue: b, alpha: 1.0)
                
            }
            
        }
        
/*
//        let size = CGFloat((info["size"] as String).toInt()!)
        let size = info["size"] as? CGFloat // still needs to be cast as a CGFloat because info: [NSObject : AnyObject]!
        let color = info["color"] as? UIColor
        
        var ballView = UIView(frame: CGRectMake(0, 0, size, size))
        ballView.backgroundColor = color
        ballView.layer.cornerRadius = size / 2
        ballView.center = view.center
        
        view.addSubview(ballView)
*/
    }
    
    func browser(browser: MCNearbyServiceBrowser!, lostPeer peerID: MCPeerID!) {
        
        println("lost \(peerID)")
        
    }

    func session(session: MCSession!, didFinishReceivingResourceWithName resourceName: String!, fromPeer peerID: MCPeerID!, atURL localURL: NSURL!, withError error: NSError!) {
        
    }

    func session(session: MCSession!, didReceiveData data: NSData!, fromPeer peerID: MCPeerID!) {
        
        let moveInfo = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as [String:CGFloat]
        
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
          
            for ballView in self.allBallViews {
                
                if ballView.displayName == peerID.displayName {
                    
                    ballView.center.x += moveInfo["x"]!
                    ballView.center.y += moveInfo["y"]!
                    
                }
                
            }
            
        })
        
        println("\(moveInfo) from \(peerID)")
        
    }
    
    func session(session: MCSession!, didReceiveStream stream: NSInputStream!, withName streamName: String!, fromPeer peerID: MCPeerID!) {
        
    }
    
    func session(session: MCSession!, didStartReceivingResourceWithName resourceName: String!, fromPeer peerID: MCPeerID!, withProgress progress: NSProgress!) {
        
    }
    
    func session(session: MCSession!, peer peerID: MCPeerID!, didChangeState state: MCSessionState) {
        
    }

}

