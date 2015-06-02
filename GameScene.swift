//
//  GameScene.swift
//  Game
//
//  Created by Jens Vandel on 30/05/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

import Foundation

class GameScene: CCScene, CCPhysicsCollisionDelegate {

    var _contentNode: CCNode?
    var _physicsNode: CCPhysicsNode?
    var _levelNode: CCNode?
    var squareman: Squareman?
    var _leftButton: CCSprite?
    var _rightButton: CCSprite?
    var _jumpButton: CCSprite?
    var touchLocation: CGPoint?
    var level: CCNode?
    var follow: CCAction?
    var _numberOfCoinsLabel: CCLabelTTF?
    var _numberOfCoinsToWinLabel: CCLabelTTF?
    var numberOfCoins: Int = 0
    var numberOfCoinsToWin: Int = 0
    
    
    func didLoadFromCCB() {
        
        self.userInteractionEnabled = true
        
        // visualize physics bodies & joints
        //_physicsNode!.debugDraw = true;
        
        //physics collisionDelegate
        _physicsNode?.collisionDelegate = self;
        
        //loads level
       level = CCBReader.load("Levels/Level1")
        _levelNode?.addChild(level)
        
        //counts the number of coins in the level
        for node in level!.children{
            if(node.isKindOfClass(Coin)){
                numberOfCoinsToWin += 1
            }
        }
        
        //creates Squareman
        squareman = CCBReader.load("Squareman") as? Squareman
        squareman!.position = ccp(246, 144)
        _levelNode?.addChild(squareman)
        
        
        //clamps the "camera" to squaremans position
        follow = CCActionFollow.actionWithTarget(squareman, worldBoundary: level!.boundingBox())as? CCAction
         _contentNode!.runAction(follow)
        
    }
    
    override func touchBegan(touch: CCTouch!, withEvent event: CCTouchEvent!) {
        touchLocation = touch.locationInNode(self)
        
        if(CGRectContainsPoint(_leftButton!.boundingBox(), touchLocation!)) {
            squareman!.walkLeft()
        }
        if(CGRectContainsPoint(_rightButton!.boundingBox(), touchLocation!)) {
           squareman!.walkRight()
        }
        if(CGRectContainsPoint(_jumpButton!.boundingBox(), touchLocation!)) {
            squareman!.jump()
        }
    }
    
    override func touchEnded(touch: CCTouch!, withEvent event: CCTouchEvent!) {
       
    }
    
    // Collision Handlers
    func ccPhysicsCollisionPostSolve(pair: CCPhysicsCollisionPair!, squareman nodeA: CCNode!, coin nodeB: CCNode!) {
        numberOfCoins += 1
        numberOfCoinsToWin -= 1
        nodeB.removeFromParent()
    }
    
    func ccPhysicsCollisionPostSolve(pair: CCPhysicsCollisionPair!, squareman nodeA: CCNode!, enemy nodeB: CCNode!) {
        squareman!.removeFromParent()
        fail()
    }
    
    override func update(delta: CCTime) {
        
        //updates Squareman
        squareman!.update()
        
        //updates _numberOfCoinsLabel text with the collected number of coins
        _numberOfCoinsLabel!.string = String(numberOfCoins)
        
        //updates _numberOfCoinsToWinLabel text with the remaining coins
        _numberOfCoinsToWinLabel!.string = String(numberOfCoinsToWin)
        
        //check if all coins have been collected
        if(numberOfCoinsToWin == 0){
            win()
        }
        
        //check if player is ouside level boundingBox
        if(!CGRectContainsPoint(level!.boundingBox(), squareman!.position)){
            fail()
        }
       
        
    }
    
    func fail() {
        
        var gameplayScene: CCScene = CCBReader.loadAsScene("FailScene")
        CCDirector.sharedDirector().replaceScene(gameplayScene);
    }
    func win() {
        
        var gameplayScene: CCScene = CCBReader.loadAsScene("WinScene")
        CCDirector.sharedDirector().replaceScene(gameplayScene);
    }
}