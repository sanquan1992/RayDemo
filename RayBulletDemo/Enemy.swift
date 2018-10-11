//
//  Enemy.swift
//  RayBulletDemo
//
//  Created by cn17181 on 2018/10/11.
//  Copyright © 2018 cn17181. All rights reserved.
//

import Foundation
import SpriteKit

class Enemy: SKSpriteNode, AllowCollision, AllowPhysic {
    
    func configPhysic() {

        physicsBody = SKPhysicsBody(rectangleOf: frame.size)
        physicsBody!.categoryBitMask = PhysicsCategory.enemy.rawValue
        physicsBody!.collisionBitMask = 0
        physicsBody!.contactTestBitMask = PhysicsCategory.heroBullet.rawValue
        //自己的子弹可以与敌人可被阻挡子弹、敌人、石头、可以被击碎的石头发生碰撞
        //不受外力影响
        physicsBody!.isDynamic = true
        physicsBody!.affectedByGravity = false
    }
    
    var heart : Int = 5
    
    enum FireType {
        //Fire ray repeast with duration time
        case fire(time: TimeInterval)
        case fireRay(time: TimeInterval, count: Int)
        case fireMissle(time: TimeInterval)
    }
    
//        required init(nodeFile: String, loc:CGPoint = .zero, heart:Int = 5) {
//            super.init(texture: nil, color: .red, size: CGSize.zero)
//        }
//
//        required init?(coder aDecoder: NSCoder) {
//            fatalError("init(coder:) has not been implemented")
//        }
    
    func fire(type: FireType, targetNodes:[SKNode]) {
        switch type {
        case .fire(let time):
            run(SKAction.repeatForever(SKAction.sequence([SKAction.wait(forDuration: 1.0), SKAction.run {
                self.fire(time, targetNodes: targetNodes)
                }]) ))
        case .fireRay(let time, let count):
            run(SKAction.repeatForever(SKAction.sequence([SKAction.wait(forDuration: 1.0), SKAction.run {
                self.fireRay(time, targetNodes: targetNodes, count: count)
                }]) ))
        case .fireMissle(let time):
            fireMissle(time, targetNodes: targetNodes)
        }
    }
    
    func fire(_ time: TimeInterval, targetNodes:[SKNode]) {
        
    }
    
    func fireRay(_ time: TimeInterval, targetNodes:[SKNode], count: Int) {
        
        let randomTarget = targetNodes[ 0 ]
        let screenH = UIScreen.main.bounds.size.height
        let perH = screenH / CGFloat(count)
        for i in 1 ... count {
            let overlay = perH * CGFloat(i)
            let controlPoint = CGPoint.init(x: position.x + CGFloat.random(min: -200, max: randomTarget.position.x), y: overlay + CGFloat.random(min: 0, max: overlay) - screenH / 2.0)
            let path = PathGenerator.randomQuadCurve(position, randomTarget.position, ctlP: controlPoint)
            let ray = RayBullet.init(texture: nil, color: .blue, size: CGSize.init(width: 10, height: 10))
            ray.actionWithPath(path: path, targetNode: self.parent, atPos: position)
        }
    }
    
    func fireMissle(_ time: TimeInterval, targetNodes:[SKNode]) {
        
    }
    
    func fireUniqueSkill(targetNodes:[SKNode]) {
        
    }
    
    deinit {
        print("Enemy was killed")
    }
}

extension Enemy: Attacked {
    
    func attacked() {
        removeAllActions()
//        removeFromParent()
    }
}
