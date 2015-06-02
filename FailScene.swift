//
//  FailScene.swift
//  Game
//
//  Created by Jens Vandel on 02/06/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

import Foundation

class FailScene: CCNode {
    
    func didLoadFromCCB() {
        runAction(CCActionSequence(array: [CCActionDelay(duration: 5), CCActionCallFunc(target: self, selector: "goToMenu")]))
    }
    
    func goToMenu(){
        
        var gameplayScene: CCScene = CCBReader.loadAsScene("MainScene")
        CCDirector.sharedDirector().replaceScene(gameplayScene);
    }
}