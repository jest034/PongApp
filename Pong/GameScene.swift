//
//  GameScene.swift
//  Pong
//
//  Created by James Xu on 2/22/17.
//  Copyright © 2017 Harvard Westlake. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    
    var ball = SKSpriteNode()
    var enemy = SKSpriteNode()
    var main = SKSpriteNode()
    
    var topLbl = SKLabelNode()
    var btmLbl = SKLabelNode()
    var score = [Int]()
    
    var menu = SKLabelNode()
    var pause = SKLabelNode()

    
    override func didMove(to view: SKView) {
        

            topLbl = self.childNode(withName: "topLabel") as! SKLabelNode
            btmLbl = self.childNode(withName: "btmLabel") as! SKLabelNode
            ball = self.childNode(withName: "ball") as! SKSpriteNode
        
            menu = self.childNode(withName: "menuButton") as! SKLabelNode
            pause = self.childNode(withName: "pauseButton") as! SKLabelNode

        
            enemy = self.childNode(withName: "enemy") as! SKSpriteNode
            enemy.position.y = (self.frame.height/2) - 50
        
        
            main = self.childNode(withName: "main") as! SKSpriteNode
            main.position.y = (-self.frame.height/2) + 50
        
        
            let border = SKPhysicsBody(edgeLoopFrom: self.frame)
        
            border.friction = 0
            border.restitution = 1
            self.physicsBody = border
            startGame()
        }
    
    func startGame()
    {
        score = [0,0]
        topLbl.text = "\(score [1])"
        btmLbl.text = "\(score [0])"
        ball.physicsBody?.applyImpulse(CGVector(dx: 10, dy: 10))
        if currentGameType != .player2
        {
            topLbl.zRotation = 0
        }
    }
    
    func addScore(playerWhoWon : SKSpriteNode)
    {
        ball.position = CGPoint(x: 0, y: 0)
        ball.physicsBody?.velocity = CGVector (dx: 0, dy: 0)
        if playerWhoWon == main{
            score[0] += 1
             ball.physicsBody?.applyImpulse(CGVector(dx: 10, dy: 10))
        }
        else if playerWhoWon == enemy {
            score [1] += 1
             ball.physicsBody?.applyImpulse(CGVector(dx: -10, dy: -10))
        }
        topLbl.text = "\(score [1])"
        btmLbl.text = "\(score [0])"
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        if let location = touch?.location (in: self)
        {
            let nodesArray = self.nodes(at: location)
            if nodesArray.first?.name == "menuButton"
            {
                let transition = SKTransition.flipVertical(withDuration: 0.5)
                let gameScene1 = GameScene(fileNamed:"MenuScene")
                self.view?.presentScene(gameScene1!, transition: transition)
            }
        }
        
        
        for touch in touches {
            let location = touch.location(in: self)
            
            if location == menu.position
            {
                let transition = SKTransition.flipVertical(withDuration: 0.5)
                let menuScene1 = GameScene(fileNamed:"MenuScene")
                self.view?.presentScene(menuScene1!, transition: transition)
            }
            if currentGameType == .player2 {
                if location.y > 0 {
                    enemy.run(SKAction.moveTo(x: location.x, duration: 0.4))
                }
                if location.y < 0 {
                    main.run(SKAction.moveTo(x: location.x, duration: 0.4))
                }
            }
            else{
                main.run(SKAction.moveTo(x: location.x, duration: 0.4))
            }

        }
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            
            if currentGameType == .player2 {
                if location.y > 0 {
                     enemy.run(SKAction.moveTo(x: location.x, duration: 0.1))
                }
                if location.y < 0 {
                     main.run(SKAction.moveTo(x: location.x, duration: 0.1))
                }
            }
            else{
                 main.run(SKAction.moveTo(x: location.x, duration: 0.1))
            }
           
        }
    }
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        switch currentGameType {
        case .easy:
            enemy.run(SKAction.moveTo(x: ball.position.x, duration: 0.7))
            break
        case .medium:
            enemy.run(SKAction.moveTo(x: ball.position.x, duration: 0.5))
            break
        case .hard:
            enemy.run(SKAction.moveTo(x: ball.position.x, duration: 0.2))
            break
        case .impossible:
            enemy.run(SKAction.moveTo(x: ball.position.x, duration: 0))
            break
        case .player2:
            
            break


        }
        
        
        
               if ball.position.y <= main.position.y - 30
        {
            addScore(playerWhoWon: enemy)
        }
        else if ball.position.y >= enemy.position.y+30
        {
            addScore(playerWhoWon: main)
        }
        
        
        //main.run(SKAction.moveTo(x: ball.position.x, duration: 0))
        ball.physicsBody?.velocity.dx.multiply(by: 1.001)
        ball.physicsBody?.velocity.dy.multiply(by: 1.001)
        
    }
}

