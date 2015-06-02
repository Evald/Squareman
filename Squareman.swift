//
//  Squareman.swift
//  Game
//
//  Created by Jens Vandel on 30/05/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

import Foundation

class Squareman: CCSprite {
    
    var state: SquaremanState?
    var maxVelocity = 200;
    
    
    func didLoadFromCCB() {
        physicsBody!.allowsRotation = false
        physicsBody.collisionType = "squareman"
        physicsBody.collisionCategories = ["squareman"]
        physicsBody.collisionMask = ["coin", "enemy"]
        stand()
        
    }
    
    func stand(){
        state = .STANDING
        animationManager.runAnimationsForSequenceNamed("standAnimation")
        physicsBody.velocity = ccp(0, physicsBody.velocity.y)
    }
    
    func walkLeft(){
        
        
            state = .WALKING
            animationManager.runAnimationsForSequenceNamed("walkAnimation")
            let walkAction = CCActionMoveBy(duration: 0.5, position: ccp(-100,0))
            
            //callback action
            let doneAction = CCActionCallFunc(target: self, selector: "stand")
            runAction(CCActionSequence(array: [walkAction, doneAction])) 
        
    }
    
    func walkRight(){
    
            state = .WALKING
            animationManager.runAnimationsForSequenceNamed("walkAnimation")
            let walkAction = CCActionMoveBy(duration: 0.5, position: ccp(100,0))
            
            //callback action
            let doneAction = CCActionCallFunc(target: self, selector: "stand")
            runAction(CCActionSequence(array: [walkAction, doneAction]))
        
    }
    
    func jump(){
        
        if(state != .JUMPING){
            state = .JUMPING
            animationManager.runAnimationsForSequenceNamed("jumpAnimation")
            
            let jumpVelocity = (physicsBody.velocity.y >= 0 ? ccp(0, 300): ccp(0, 0))
            let jumpAction = CCActionJumpBy(duration: 1, position: jumpVelocity, height: 0.5, jumps: 1)
            
            //callback action
            let doneAction = CCActionCallFunc(target: self, selector: "stand")
            runAction(CCActionSequence(array: [jumpAction, doneAction]))
        }
        
    }
    
    func update(){
        
    }
}