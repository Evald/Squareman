//
//  Coin.swift
//  Game
//
//  Created by Jens Vandel on 30/05/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

import Foundation

class Coin : CCSprite {
    
    let moveAction: CCActionSequence = CCActionSequence(array: [ CCActionMoveBy(duration: 2, position: ccp(0,10)), CCActionMoveBy(duration: 2, position: ccp(0,-10))])
    
    func didLoadFromCCB() {
        physicsBody.collisionType = "coin"
        physicsBody.collisionCategories = ["coin"]
        physicsBody.collisionMask = ["squareman"]
        runAction(CCActionRepeatForever(action: moveAction))
    }
    
    func removeCoin(){
        removeFromParent()
    }
    
    
}