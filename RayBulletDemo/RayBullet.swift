//
//  RayBullet.swift
//  RayBulletDemo
//
//  Created by mac on 2018/10/10.
//  Copyright © 2018年 cn17181. All rights reserved.
//

import Foundation
import SpriteKit

protocol AllowCollision {
    //...
}

extension AllowCollision where Self:SKNode {
    
    func collisionHappen(_ uTime: TimeInterval) {
        //TODO: add union code for boundary check
    }
}

class RayBullet: SKNode, AllowCollision {
    
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
    
    
    required init(targetNode:SKNode, speed:CGFloat = 200, sksFile: String?) {
        self.targetNode = targetNode
        self.raySpeed = speed
        if sksFile == nil {
            emitter = SKEmitterNode.init(fileNamed: "fire.sks")
        }else {
            emitter = SKEmitterNode.init(fileNamed: sksFile!)
            //config
        }
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func actionWithPath(path:CGPath, targetNode: SKNode?, atPos:CGPoint) {
        
        guard let targetNode = targetNode else { return }
        let buNode = SKNode()
        buNode.position = atPos
        targetNode.addChild(buNode)
        buNode.addChild(emitter)
        emitter.targetNode = targetNode
        buNode.run(SKAction.sequence([SKAction.follow(path, speed: 600.0), SKAction.wait(forDuration: 1.5), SKAction.run {
            buNode.removeFromParent()
            }]))
    }
    
    deinit {
        print("bullet disappear")
    }
}
