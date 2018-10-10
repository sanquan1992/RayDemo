//
//  Hero.swift
//  RayBulletDemo
//
//  Created by mac on 2018/10/10.
//  Copyright © 2018年 cn17181. All rights reserved.
//

import Foundation
import SpriteKit

class Hero: SKSpriteNode {
    
    var heart : Int = 5
    
    enum FireType {
        //Fire ray repeast with duration time
        case fire(time: TimeInterval)
        case fireRay(time: TimeInterval, count: Int)
        case fireMissle(time: TimeInterval)
        case fireUniqueSkill
    }
    
//    required init(nodeFile: String, loc:CGPoint = .zero, heart:Int = 5) {
//        self.heart = heart
//        super.init(fileNamed: nodeFile)
//
//    }
    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
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
        case .fireUniqueSkill:
            fireUniqueSkill(targetNodes: targetNodes)
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
            let ray = RayBullet.init(targetNode: self, sksFile: nil)
            ray.actionWithPath(path: path, targetNode: self.parent, atPos: position)
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
