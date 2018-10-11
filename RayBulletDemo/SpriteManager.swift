//
//  SpriteManager.swift
//  RayBulletDemo
//
//  Created by cn17181 on 2018/10/11.
//  Copyright © 2018 cn17181. All rights reserved.
//

import Foundation
import SpriteKit

class SpriteManager: NSObject {
    
    static let shared = SpriteManager()
    
    var enemies:[SKSpriteNode] = []
    var enemyBullets: [SKSpriteNode] = []
    var enemyBulletsAttackable: [SKSpriteNode] = []
    var heroBullets: [SKSpriteNode] = []
    var blocks: [SKSpriteNode] = []
    var blocksAttackable: [SKSpriteNode] = []
    var heros: [Hero] = []
    
}
