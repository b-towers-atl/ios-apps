//
//  ViewController.swift
//  Leaderboard
//
//  Created by Bobby Towers on 3/4/15.
//  Copyright (c) 2015 Bobby Towers. All rights reserved.
//

// GKLeaderboard
// GKLocalPlayer
// GKScore
// GKLeaderboardViewController

import UIKit
import GameKit

class ViewController: UIViewController, UINavigationControllerDelegate, GKGameCenterControllerDelegate {

    var attacks: Int64 = 0
    
    @IBOutlet weak var attackLabel: UILabel!

    @IBAction func attackButton(sender: AnyObject) {
        
        attacks++
        
        attackLabel.text = "Attacks: \(attacks)"
        
        // submit attack score
        
        var score = GKScore(leaderboardIdentifier: "attack_leaderboard")
        score.value = attacks
        GKScore.reportScores([score], withCompletionHandler: { (error) -> Void in
            
            println("score reported")
            
        })
        
    }
    
    @IBAction func leaderboardButton(sender: AnyObject) {
        
        // present leaderboard
        
        var leaderboardVC = GKGameCenterViewController()
        leaderboardVC.leaderboardIdentifier = "attack_leaderboard"
        leaderboardVC.delegate = self
        
        presentViewController(leaderboardVC, animated: true, completion: nil)
    }
    
    func gameCenterViewControllerDidFinish(gameCenterViewController: GKGameCenterViewController!) {
        
        gameCenterViewController.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        GKLocalPlayer.localPlayer().authenticateHandler = { (viewController: UIViewController!, error: NSError!) -> Void in
            
            if !GKLocalPlayer.localPlayer().authenticated {
                
                self.presentViewController(viewController, animated: true, completion: nil)
                
            }
            
            println("authentication done = \(GKLocalPlayer.localPlayer().authenticated)")
            // local player is authenticated
        
        }
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

