//
//  GameScene.swift
//  RayBulletDemo
//
//  Created by cn17181 on 2018/10/10.
//  Copyright © 2018 cn17181. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var entities = [GKEntity]()
    var graphs = [String : GKGraph]()
    
    private var hero: SKSpriteNode?
    private var enemy: SKSpriteNode?
    
    
    private var lastUpdateTime : TimeInterval = 0
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    
    override func sceneDidLoad() {

        self.lastUpdateTime = 0
        
        // Get label node from scene and store it for use later
//        self.label = self.childNode(withName: "//helloLabel") as? SKLabelNode
//        if let label = self.label {
//            label.alpha = 0.0
//            label.run(SKAction.fadeIn(withDuration: 2.0))
//        }
//
        hero = self.childNode(withName: "//Hero") as? SKSpriteNode
        enemy = self.childNode(withName: "//Enemy") as? SKSpriteNode
        
        if let hero = hero, let enemy = enemy {
            hero.run(SKAction.repeatForever(SKAction.rotate(byAngle: CGFloat(Double.pi), duration: 1)))
            enemy.run(SKAction.repeatForever(SKAction.rotate(byAngle: CGFloat(Double.pi), duration: 1)))
        }
        
        
        
        // Create shape node to use during mouse interaction
        let w = (self.size.width + self.size.height) * 0.05
        self.spinnyNode = SKShapeNode.init(rectOf: CGSize.init(width: w, height: w), cornerRadius: w * 0.3)
        
        if let spinnyNode = self.spinnyNode {
            spinnyNode.lineWidth = 2.5
            
            spinnyNode.run(SKAction.repeatForever(SKAction.rotate(byAngle: CGFloat(Double.pi), duration: 1)))
            spinnyNode.run(SKAction.sequence([SKAction.wait(forDuration: 0.5),
                                              SKAction.fadeOut(withDuration: 0.5),
                                              SKAction.removeFromParent()]))
        }
        
        hero?.run(SKAction.repeatForever(SKAction.sequence([SKAction.wait(forDuration: 1.0), SKAction.run {
            self.hitEnemy()
        }]) ))
    
    }
    
    func hitEnemy() {
        guard let hero = hero, let enemy = enemy else { return }
        let toPoint = CGPoint.init(x: enemy.position.x - hero.position.x, y: enemy.position.y - hero.position.y)
        let amount:CGFloat = enemy.position.y > 0 ? 40 : -40
        let controlPoint = CGPoint.init(x: toPoint.x / 2.0, y: enemy.position.y + amount)
        let path = UIBezierPath()
        path.lineWidth = 40.0
        path.lineCapStyle = .round
        path.lineJoinStyle = .round
        path.move(to: .zero)
        path.addQuadCurve(to: toPoint, controlPoint: controlPoint)
        path.stroke()
        let shapeNode = SKShapeNode.init(path: path.cgPath)
        shapeNode.strokeColor = SKColor.red
        shapeNode.position = hero.position
        shapeNode.lineWidth = 20
        addEffect(to: shapeNode)
        addChild(shapeNode)
        shapeNode.run(SKAction.wait(forDuration: 2.0)) {
            shapeNode.strokeShader = nil
            shapeNode.removeFromParent()
        }
    }
    
    func addEffect(to bullet:SKShapeNode) {
        
        let shader = SKShader.init(fileNamed: "rayBullet.fsh")
        bullet.strokeShader = shader
    }
    
    
    func touchDown(atPoint pos : CGPoint) {
//        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
//            n.position = pos
//            n.strokeColor = SKColor.green
//            self.addChild(n)
//        }
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        guard let hero = hero, let enemy = enemy else { return }
        enemy.position = pos
    }
    
    func touchUp(atPoint pos : CGPoint) {
//        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
//            n.position = pos
//            n.strokeColor = SKColor.red
//            self.addChild(n)
//        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        if let label = self.label {
//            label.run(SKAction.init(named: "Pulse")!, withKey: "fadeInOut")
//        }
        
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        // Initialize _lastUpdateTime if it has not already been
        if (self.lastUpdateTime == 0) {
            self.lastUpdateTime = currentTime
        }
        
        // Calculate time since last update
        let dt = currentTime - self.lastUpdateTime
        
        // Update entities
        for entity in self.entities {
            entity.update(deltaTime: dt)
        }
        
        self.lastUpdateTime = currentTime
    }
}
