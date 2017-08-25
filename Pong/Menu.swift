//
//  Menu.swift
//  Pong
//
//  Created by James Xu on 3/14/17.
//  Copyright © 2017 Harvard Westlake. All rights reserved.
//

import Foundation
import GameplayKit
import SpriteKit

enum gameType {
    case easy
    case medium
    case hard
    case impossible
    case player2
}


class Menu : SKScene {
    
   

    var TwoPlayer = SKLabelNode()
    var Easy = SKLabelNode()
    var Medium = SKLabelNode()
    var Hard = SKLabelNode()
    var Impossible = SKLabelNode()
    var pong = SKLabelNode()
    var Options = SKLabelNode()
    
    override func didMove(to view: SKView) {
        TwoPlayer = self.childNode(withName: "TwoPlayer") as! SKLabelNode
        Easy = self.childNode(withName: "Easy") as! SKLabelNode
        Medium = self.childNode(withName: "Medium") as! SKLabelNode
        Hard = self.childNode(withName: "Hard") as! SKLabelNode
        Impossible = self.childNode(withName: "Impossible") as! SKLabelNode
        pong = self.childNode(withName: "Pong") as! SKLabelNode
        Options = self.childNode(withName: "Options") as! SKLabelNode
            
        pong.position.y = (self.frame.height/2) - 75
        TwoPlayer.position.y = (self.frame.height/2) - 175
        Easy.position.y = (self.frame.height/2) - 275
        Medium.position.y = (self.frame.height/2) - 375
        Hard.position.y = (self.frame.height/2) - 475
        Impossible.position.y = (self.frame.height/2) - 575
        Options.position.y = (self.frame.height/2) - 675
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let touch = touches.first
        if let location = touch?.location (in: self)
        {
            let nodesArray = self.nodes(at: location)
            if nodesArray.first?.name == "TwoPlayer"
            {
                moveToGame(game: .player2)
            }
            if nodesArray.first?.name == "Easy"
            {
                moveToGame(game: .easy)
            }
            if nodesArray.first?.name == "Medium"
            {
                moveToGame(game: .medium)
            }
            if nodesArray.first?.name == "Hard"
            {
                moveToGame(game: .hard)
            }
            if nodesArray.first?.name == "Impossible"
            {
                moveToGame(game: .impossible)
            }
            
        }
        
    }
    
    
    
    
    func moveToGame(game : gameType)
    {
        let transition = SKTransition.flipVertical(withDuration: 0.5)
        let gameScene1 = GameScene(fileNamed:"GameScene")
        currentGameType = game
        self.view?.presentScene(gameScene1!, transition: transition)
        
    }
    
    
}
