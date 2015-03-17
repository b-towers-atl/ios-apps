//
//  ViewController.swift
//  Bubbles
//
//  Created by Bobby Towers on 3/17/15.
//  Copyright (c) 2015 Bobby Towers. All rights reserved.
//

// CAN ONLY RUN ON THE PHONE

import UIKit
import AVFoundation

class ViewController: UIViewController, AVCaptureAudioDataOutputSampleBufferDelegate {

    var audioSession = AVAudioSession()
    var audioDataOutput = AVCaptureAudioDataOutput()
    var audioCaptureSession = AVCaptureSession()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        audioSession.setCategory(AVAudioSessionCategoryRecord, error: nil)
        audioSession.setMode(AVAudioSessionModeMeasurement, error: nil)
        audioSession.setActive(true, error: nil)
        audioSession.setPreferredSampleRate(48000, error: nil)
        
        var myDevice = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeAudio)
        var audioCaptureInput = AVCaptureDeviceInput(device: myDevice, error: nil)
        
        audioCaptureSession.addInput(audioCaptureInput)
        
        // This gets global queue
        audioDataOutput.setSampleBufferDelegate(self, queue: dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0))
        
        audioCaptureSession.addOutput(audioDataOutput)
        
        audioCaptureSession.startRunning()
        
        view.addSubview(powerCircle)
        
        powerCircle.backgroundColor = UIColor.blueColor()
    }
    
    var powerCircle = UIView()
    
    func captureOutput(captureOutput: AVCaptureOutput!, didOutputSampleBuffer sampleBuffer: CMSampleBuffer!, fromConnection connection: AVCaptureConnection!) {
        
        for channel in connection.audioChannels as [AVCaptureAudioChannel] {
            
            let pLevel = CGFloat((channel.averagePowerLevel + 50) * 2)
            
            // This is UI stuff, and it runs horribly on a background thread
            // Instead, move these to main queue
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                // Now this is in the main thread
                
                if channel.averagePowerLevel > -10 {
                    // blow bubblezzz!!!!
                    
                    // Create bubble
                    var bubble = UIView(frame: CGRectMake(0, 0, 50, 50))
                    bubble.backgroundColor = UIColor.cyanColor()
                    bubble.layer.cornerRadius = 25
                    bubble.alpha = 0.5
                    
                    // This creates our bubble from the bottom center of our screen
                    bubble.center = CGPointMake(self.view.center.x, self.view.frame.height)
                    
                    self.view.addSubview(bubble)
                    
                    UIView.animateWithDuration(0.4, animations: { () -> Void in
                        
                        let x = arc4random_uniform(UInt32(self.view.frame.width))
//                        let y = arc4random_uniform(UInt32(self.view.frame.height))
                        let y = self.view.frame.height - pLevel * 8
                        
                        bubble.center = CGPointMake(CGFloat(x), y)
                        
//                        bubble.center = CGPointMake(self.view.center.x, -self.view.frame.height)
                        
                    }, completion: { (success) -> Void in
                        
                        bubble.removeFromSuperview()
                        
                    })
                    
                }
                
                // Power circle!!! Grows out and in as it hears audio
                self.powerCircle.frame = CGRectMake(0, 0, pLevel, pLevel)
                self.powerCircle.layer.cornerRadius = pLevel / 2
                self.powerCircle.center = self.view.center
            })
            
            println("Audio Power Level = \(channel.averagePowerLevel) & Peak Hold Level = \(channel.peakHoldLevel)")
            
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

