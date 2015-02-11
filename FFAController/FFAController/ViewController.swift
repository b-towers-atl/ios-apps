//
//  ViewController.swift
//  FFAController
//
//  Created by Bobby Towers on 2/10/15.
//  Copyright (c) 2015 Bobby Towers. All rights reserved.
//

/*
+ Create a new app called FFAController
+ take the multipeer connectivity setup from Ball (not including the discovery info)
+ on storyboard add 4 directional buttons on the left and 2 fire buttons on the right (normal, special)
- connect actions to the buttons and make them run session.sendData... will a dictionary with key:value of "direction":"left" or "fire":"special"
*/

import UIKit
import MultipeerConnectivity

class ViewController: UIViewController, MCSessionDelegate, MCNearbyServiceAdvertiserDelegate {

    var session: MCSession!
    var myPeerID: MCPeerID!
    var advertiser: MCNearbyServiceAdvertiser!
    
    let serviceType = "brawling10"
    
    
    func movement(x: CGFloat, y: CGFloat, xChange: CGFloat, yChange: CGFloat) {
        
        var moveInfo = ["x":x + xChange, "y":y + yChange]
        
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
    
/*
    var lastLocation: CGPoint?
    func lastLocationCheck() {
        
        // need data from the MC host
        let location = touch.locationInView(view)
        
        if let ll = lastLocation {
            
            let xMove = location.x - ll.x
            let yMove = location.y - ll.y
            
            up(xMove, y: yMove)
            
        }
        
        lastLocation = location
        
    }
*/
    
    @IBAction func up(sender: AnyObject) {
//        up() function but use last location arguments, where do we get last location?
    }
    func up(x: CGFloat, y: CGFloat) {
        movement(x, y: y, xChange: 0, yChange: -10)
    }
    
    @IBAction func down(sender: AnyObject) {
    }
    func down(x: CGFloat, y: CGFloat) {
        movement(x, y: y, xChange: 0, yChange: 10)
    }
    
    @IBAction func left(sender: AnyObject) {
    }
    func left(x: CGFloat, y: CGFloat) {
        movement(x, y: y, xChange: -10, yChange: 0)
    }
    
    @IBAction func right(sender: AnyObject) {
    }
    func right(x: CGFloat, y: CGFloat) {
        movement(x, y: y, xChange: 10, yChange: 0)
    }
    
    @IBAction func fireNormal(sender: AnyObject) {
    }
    
    @IBAction func fireSpecial(sender: AnyObject) {
    }
    
    var upDir = "up"
    var downDir = "down"
    var leftDir = "left"
    var rightDir = "right"
    
    var normalFire = "normal"
    var specialFire = "special"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myPeerID = MCPeerID(displayName: "Who put magnets in my helmet? 🎯")
        
        session = MCSession(peer: myPeerID)
        session.delegate = self
        
        advertiser = MCNearbyServiceAdvertiser(peer: myPeerID, discoveryInfo: ["directionUp":upDir, "directionLeft":leftDir,"directionRight":rightDir,"directionDown":downDir,"fireButtonNormal":normalFire,"fireButtonSpecial":specialFire], serviceType: serviceType)
        advertiser.delegate = self
        
        advertiser.startAdvertisingPeer()
    }
    
//    func sendMove(x: CGFloat, y: CGFloat) {
//        
//        let moveInfo = ["x":x, "y":y]
//        
//        // this turns our dictionary into an NSData object
//        let moveData = NSJSONSerialization.dataWithJSONObject(moveInfo, options: NSJSONWritingOptions.allZeros, error: nil)
//        
//        println(roomPeerID)
//        println(session.connectedPeers)
//        
//        if let roomPeerID = roomPeerID {
//            
//            var error: NSError?
//            
//            session.sendData(moveData, toPeers: [roomPeerID], withMode: MCSessionSendDataMode.Reliable, error: &error)
//            
//            println(error)
//            
//        }
//        
//    }
    
//    var lastLocation: CGPoint?
//    
//    override func touchesMoved(touches: NSSet, withEvent event: UIEvent) {
//        
//        if let touch = touches.allObjects.last as? UITouch {
//            
//            let location = touch.locationInView(view)
//            
//            if let ll = lastLocation {
//                
//                let xMove = location.x - ll.x
//                let yMove = location.y - ll.y
//                
//                sendMove(xMove, y: yMove)
//                
//            }
//            
//            lastLocation = location
//            
//            
//        }
//        
//    }
    
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

