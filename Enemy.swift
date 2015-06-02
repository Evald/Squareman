//
//  Enemy.swift
//  Game
//
//  Created by Jens Vandel on 01/06/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

import Foundation

class Enemy: CCSprite {
    
    func didLoadFromCCB() {
        physicsBody.collisionType = "enemy"
        physicsBody.collisionCategories = ["enemy"]
        physicsBody.collisionMask = ["squareman"]
    }
}