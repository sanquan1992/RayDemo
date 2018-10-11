//
//  Hero.swift
//  RayBulletDemo
//
//  Created by mac on 2018/10/10.
//  Copyright © 2018年 cn17181. All rights reserved.
//

import Foundation
import SpriteKit

protocol AllowPhysic{
    func configPhysic()
}

class Hero: SKSpriteNode, AllowCollision, AllowPhysic {
    
    func configPhysic() {
        
    }
    
    var heart : Int = 5
    var physicCategory: PhysicsCategory {
        return [.friend]
    }
    
    enum FireType {
        //Fire ray repeast with duration time
        case fire(time: TimeInterval)
        case fireRay(time: TimeInterval, count: Int)
        case fireMissle(time: TimeInterval)
        case fireUniqueSkill
    }
    
//    required init(nodeFile: String, loc:CGPoint = .zero, heart:Int = 5) {
//        super.init(texture: nil, color: .red, size: CGSize.zero)
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    func fire(type: FireType, targetNodes:[SKNode]) {
        switch type {
        case .fire(let time):
            run(SKAction.repeatForever(SKAction.sequence([SKAction.wait(forDuration: time), SKAction.run {
                self.fire(time, targetNodes: targetNodes)
            }]) ))
        case .fireRay(let time, let count):
            run(SKAction.repeatForever(SKAction.sequence([SKAction.wait(forDuration: time), SKAction.run {
                self.fireRay(time, targetNodes: targetNodes, count: count)
                }]) ))
        case .fireMissle(let time):
            fireMissle(time, targetNodes: targetNodes)
        case .fireUniqueSkill:
            fireUniqueSkill(targetNodes: targetNodes)
        }
    }
    
    func fire(_ time: TimeInterval, targetNodes:[SKNode]) {
        
    }
    
    func fireRay(_ time: TimeInterval, targetNodes:[SKNode], count: Int) {
        
        let randomTarget = targetNodes[ 0 ]
        let screenH = UIScreen.main.bounds.size.height
        let perH = 900 / CGFloat(count)
        for i in 1 ... count {
            let overlay = perH * CGFloat(i)
            let controlPoint = CGPoint.init(x: position.x + CGFloat.random(min: -1000, max: 0), y: overlay + CGFloat.random(min: 0, max: overlay) - screenH / 2.0)
            let path = PathGenerator.randomQuadCurve(position, randomTarget.position, ctlP: controlPoint)
            let ray = RayBullet.init(texture: nil, color: .blue, size: CGSize.init(width: 2, height: 2))
            let firePos = CGPoint.init(x: position.x + frame.size.width / 2.0, y: position.y)
            ray.actionWithPath(path: path, targetNode: self.parent, atPos: firePos)
        }
    }
    
    func fireMissle(_ time: TimeInterval, targetNodes:[SKNode]) {
        
    }
    
    func fireUniqueSkill(targetNodes:[SKNode]) {
        
    }
    
    deinit {
        print("Hero was killed")
    }
}



