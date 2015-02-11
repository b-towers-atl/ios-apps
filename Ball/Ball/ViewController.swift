//
//  ViewController.swift
//  Ball
//
//  Created by Bobby Towers on 2/10/15.
//  Copyright (c) 2015 Bobby Towers. All rights reserved.
//

import UIKit
import MultipeerConnectivity

class ViewController: UIViewController, MCSessionDelegate, MCNearbyServiceAdvertiserDelegate {

    var session: MCSession!
    var myPeerID: MCPeerID!
    var advertiser: MCNearbyServiceAdvertiser!
    
    let serviceType = "b2"
    
//    var color = UIColor(red:0, green:0.98, blue:0.49, alpha:1)
    var colorR = "1.00"
    var colorG = "1.00"
    var colorB = "1.00"
    var size = "25"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myPeerID = MCPeerID(displayName: "only 1 highlander")
        
        session = MCSession(peer: myPeerID)
        session.delegate = self

        advertiser = MCNearbyServiceAdvertiser(peer: myPeerID, discoveryInfo: ["colorR":colorR,"colorG":colorG,"colorB":colorB,"size":size], serviceType: serviceType)
        advertiser.delegate = self
        
        advertiser.startAdvertisingPeer()
    }
    
    func sendMove(x: CGFloat, y: CGFloat) {
        
        let moveInfo = ["x":x, "y":y]
        
        // this turns our dictionary into an NSData object
        let moveData = NSJSONSerialization.dataWithJSONObject(moveInfo, options: NSJSONWritingOptions.allZeros, error: nil)
        
        println(roomPeerID)
        println(session.connectedPeers)
        
        if let roomPeerID = roomPeerID {
            
            var error: NSError?
        
            session.sendData(moveData, toPeers: [roomPeerID], withMode: MCSessionSendDataMode.Reliable, error: &error)
            
            println(error)
            
        }
        
    }

    
    var lastLocation: CGPoint?
    
    override func touchesMoved(touches: NSSet, withEvent event: UIEvent) {
        
        if let touch = touches.allObjects.last as? UITouch {
            
            let location = touch.locationInView(view)
            
            if let ll = lastLocation {
                
                let xMove = location.x - ll.x
                let yMove = location.y - ll.y
                
                sendMove(xMove, y: yMove)
                
            }
            
            lastLocation = location
            
            
        }
        
    }

    var roomPeerID: MCPeerID?
    
    func advertiser(advertiser: MCNearbyServiceAdvertiser!, didReceiveInvitationFromPeer peerID: MCPeerID!, withContext context: NSData!, invitationHandler: ((Bool, MCSession!) -> Void)!) {
        
        roomPeerID = peerID
        
        println("invite from \(peerID)")
        
        invitationHandler(true,session)
        
    }
    
    func session(session: MCSession!, didFinishReceivingResourceWithName resourceName: String!, fromPeer peerID: MCPeerID!, atURL localURL: NSURL!, withError error: NSError!) {
        
        
    }
    
    func session(session: MCSession!, didReceiveData data: NSData!, fromPeer peerID: MCPeerID!) {
        
    }
    
    func session(session: MCSession!, didReceiveStream stream: NSInputStream!, withName streamName: String!, fromPeer peerID: MCPeerID!) {
        
    }
    
    func session(session: MCSession!, didStartReceivingResourceWithName resourceName: String!, fromPeer peerID: MCPeerID!, withProgress progress: NSProgress!) {
        
    }
    
    func session(session: MCSession!, peer peerID: MCPeerID!, didChangeState state: MCSessionState) {
        
        println("\(state.rawValue) = \(peerID)")
        
        println(session.connectedPeers)
        
    }

}

