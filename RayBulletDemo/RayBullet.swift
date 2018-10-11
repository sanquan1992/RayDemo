//
//  RayBullet.swift
//  RayBulletDemo
//
//  Created by mac on 2018/10/10.
//  Copyright © 2018年 cn17181. All rights reserved.
//

import Foundation
import SpriteKit

protocol Attacked  {
    //When self was attacked, will happen something
    func attacked()
}

enum SpriteType {
    case Friend // be attacked
    case Enemy  // be attacked
    case Bullet(friendly:Bool) // be attacked
    case Block  // barrier, but can be attacked
    case Transparency  // can not be attacked, just background component
    
    func name() -> String {
        switch self {
        case .Friend:
            return "friend"
        case .Enemy:
            return "enemy"
        case .Block:
            return "block"
        case .Transparency:
            return "transparency"
        case .Bullet(let friendly):
            if friendly {
                return "friendBullet"
            }
            return "enemyBullet"
        }
    }
}

protocol EdgeCheck {
    //...
}

extension EdgeCheck where Self:SKSpriteNode {
    
    func checkEdgeCollision() {
        let maxWidth = UIScreen.main.bounds.size.width / 2.0
        let maxHeight = UIScreen.main.bounds.size.height / 2.0
        if abs(position.x) > maxWidth || abs(position.y) > maxHeight {
            if let `self` = self as? Attacked {
                self.attacked()
            }
        }
    }
}

/// Protocol for frame interaction check
//  No need node has physic body
protocol AllowCollision {
    //...
}

extension AllowCollision where Self:SKNode {
    
    func checkCollision<T>(_ target: T) where T : Attacked {
//        if frame.intersects(target.frame) {
//            target.attacked()
//            if let `self` = self as? Attacked {
//                self.attacked()
//            }
//        }
    }
}

class RayBullet: SKSpriteNode, AllowCollision, EdgeCheck, AllowPhysic {
    
    func configPhysic() {
        
        physicsBody = SKPhysicsBody(rectangleOf: frame.size)
        physicsBody!.categoryBitMask = PhysicsCategory.heroBullet.rawValue
        physicsBody!.collisionBitMask = 0
        physicsBody!.contactTestBitMask = PhysicsCategory.enemyBulletAttackable.rawValue |
                                        PhysicsCategory.enemy.rawValue |
                                        PhysicsCategory.block.rawValue |
                                        PhysicsCategory.blockAttackable.rawValue
        //自己的子弹可以与敌人可被阻挡子弹、敌人、石头、可以被击碎的石头发生碰撞
        //不受外力影响
        physicsBody!.isDynamic = true
        physicsBody!.affectedByGravity = false
    }
    
    var targetNode: SKNode!
    var raySpeed: CGFloat = 200
    var emitter: SKEmitterNode!
    
    enum ExplosionType {
        //when collision with enmey with explose with diffusion
        case diffusion(time: TimeInterval)
        //when collision with edge, just disappear
        case disappear(time: TimeInterval)
    }
    var explosionType: ExplosionType = .diffusion(time: 0.5)
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        emitter = SKEmitterNode.init(fileNamed: "fire.sks")
        super.init(texture: texture, color: color, size: size)
        self.configPhysic()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func actionWithPath(path:CGPath, targetNode: SKNode?, atPos:CGPoint) {
        
        guard let targetNode = targetNode else { return }
        addChild(emitter)
        position = atPos
        targetNode.addChild(self)
        emitter.targetNode = targetNode
        run(SKAction.follow(path, speed: 1200)) {
            self.removeFromParent()
        }
    }
    
    deinit {
        print("bullet disappear")
    }
    
}

extension RayBullet: Attacked {
    
    func attacked() {
        //remove from scene
        removeAllChildren()
        removeAllActions()
        removeFromParent()
    }
}
/// Protocol for physic body collision check
// Need node has physic body
protocol AllowPhysicCollision {
    
}

extension AllowPhysicCollision where Self:SKSpriteNode {
    
    private func physicCollisionHappen() {
        //TODO: add union code for physic collision check
    }
}
