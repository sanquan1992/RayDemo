//
//  GameScene.swift
//  RayBulletDemo
//
//  Created by cn17181 on 2018/10/10.
//  Copyright © 2018 cn17181. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var entities = [GKEntity]()
    var graphs = [String : GKGraph]()
    
    private var hero: Hero
    
    private var lastUpdateTime : TimeInterval = 0
    
    let playableRect:CGRect
    
    override init(size: CGSize) {
        //IphoneX之后的手机都不是16:9的屏幕，更长， 不考虑4:3的屏幕
        let maxAspectRatio:CGFloat = 16.0 / 9.0
        let playableWidth = size.height * maxAspectRatio
        let playableMargin = (size.width-playableWidth)/2.0
        playableRect = CGRect(x: playableMargin, y: 0,
                              width: playableWidth,
                              height: size.height)
        let texture = SKTexture.init(imageNamed: "gun")
        hero = Hero(texture: texture, size: texture.size())
        hero.setScale(0.4)
        hero.position = CGPoint.init(x: playableRect.origin.x + 400, y: playableRect.origin.y + 200)
        super.init(size: size)
        physicsBody = SKPhysicsBody(edgeLoopFrom: playableRect)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func sceneDidLoad() {
        
        self.lastUpdateTime = 0
        
    }
    
    func spawnEnemy() {
        let enemy = Enemy(color: .green, size: CGSize.init(width: 40, height: 40))
        enemy.configPhysic()
        enemy.position = CGPoint.init(x: playableRect.origin.x  + 2000, y: playableRect.origin.y + 600)
        addChild(enemy)
        hero.fire(type: .fireRay(time: 2.0, count: 6), targetNodes: [enemy])
    }
    
    override func didMove(to view: SKView) {
    
        physicsWorld.contactDelegate = self
        addChild(hero)
        hero.configPhysic()
        spawnEnemy()
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
        hero.position = pos
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

    
    //碰撞发生
    //TODO: 问题一， 如何子弹的Collision -> ON， 那么自己的子弹之间的碰撞也会产生物理效果，
    //      需要解决， 可能只能使用Frame的intersets来解决
    func didBegin(_ contact: SKPhysicsContact) {
        
        if let nodeA = contact.bodyA.node as? Attacked {
            nodeA.attacked()
        }
        if let nodeB = contact.bodyB.node as? Attacked {
            nodeB.attacked()
        }
        
    }

    
}


