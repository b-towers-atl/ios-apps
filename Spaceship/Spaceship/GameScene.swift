//
//  GameScene.swift
//  Spaceship
//
//  Created by Bobby Towers on 2/9/15.
//  Copyright (c) 2015 Bobby Towers. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    override func didMoveToView(view: SKView) {
//        /* Setup your scene here */
//        let myLabel = SKLabelNode(fontNamed:"HelveticaNeue-Thin")
//        myLabel.text = "Spaceship Swag";
//        myLabel.fontSize = 65;
//        
//        // position is the center of a node based on bottom left of its parent node
//        myLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame));
//        
//        // parent is self and myLabel is the child, adding the child to the parent
//        self.addChild(myLabel)
        
        println(self.physicsBody)
        
        // physics world is the environment for your game
        self.physicsWorld.gravity = CGVectorMake(0.0, -2.0)
        
//        self.physicsBody = SKPhysicsBody(edgeLoopFromRect: self.frame)
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        
        for touch: AnyObject in touches {
            let location = touch.locationInNode(self)
            
            let fireBallPath = NSBundle.mainBundle().pathForResource("FireBall", ofType: "sks")
            let fireBall = NSKeyedUnarchiver.unarchiveObjectWithFile(fireBallPath!) as SKEmitterNode
            fireBall.particleBirthRate = 50
            
//            let ball = SKShapeNode(circleOfRadius: 20)
//            ball.position = location
            fireBall.position = location
            
            let physicsBody = SKPhysicsBody(circleOfRadius: 20)
//            ball.physicsBody = physicsBody
            fireBall.physicsBody = physicsBody
            
            physicsBody.affectedByGravity = true
            
//            self.addChild(ball)
            self.addChild(fireBall)
            
            // initial push but then it tapers off
            physicsBody.applyForce(CGVectorMake(600.0, 100.0))
            
        }
        
    }
    
    override func touchesMoved(touches: NSSet, withEvent event: UIEvent) {
        /* Called when a touch begins */
        
        for touch: AnyObject in touches {
            
            let location = touch.locationInNode(self)
            
        
            
            
            // circle
//            let circle = SKShapeNode(circleOfRadius: 20)
//            circle.strokeColor = SKColor.clearColor()
//            circle.position = location
//            circle.physicsBody = SKPhysicsBody(circleOfRadius: 20)
//            circle.fillColor = SKColor.greenColor()
//            
//            let colorArray: [SKColor] = [SKColor.redColor(), SKColor.greenColor(), SKColor.blueColor()]
//
//            var index = 0
//            while index < colorArray.count {
//                
//                circle.fillColor = colorArray[index]
//                
//                index++
//            }
//
//            
//            self.addChild(circle)
        
            
            
            
            
            
//            let sprite = SKSpriteNode(imageNamed:"Spaceship")
//            
//            sprite.xScale = 0.5
//            sprite.yScale = 0.5
//            sprite.position = location
//            
//            let action = SKAction.rotateByAngle(CGFloat(M_PI), duration:1)
//            
//            sprite.runAction(SKAction.repeatActionForever(action))
//            
//            self.addChild(sprite)
        }
        
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        
        // always garbage collect nodes for performance
        for child in self.children as [SKNode] {
            
            if child.position.y < -50 {
                
                child.removeFromParent()
                
//                child.position.y = self.frame.height + 100
                
            }
            
        }
        
//        println(self.children.count)
    }
}
