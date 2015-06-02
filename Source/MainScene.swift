import Foundation

class MainScene: CCNode {

    func play(){
        
        var gameplayScene: CCScene = CCBReader.loadAsScene("GameScene")
        CCDirector.sharedDirector().replaceScene(gameplayScene);
    }
}
