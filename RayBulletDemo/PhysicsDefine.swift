//
//  PhysicsDefine.swift
//  RayBulletDemo
//
//  Created by cn17181 on 2018/10/11.
//  Copyright © 2018 cn17181. All rights reserved.
//

import Foundation

struct PhysicsCategory: OptionSet {
    
    let rawValue:UInt32
    typealias RawValue = UInt32
    
    init(rawValue: RawValue) {
        self.rawValue = rawValue
    }
    
    static let friend = PhysicsCategory(rawValue: 1 << 0)
    static let hero = PhysicsCategory(rawValue: 1 << 1)
    static let heroBullet = PhysicsCategory(rawValue: 1 << 2)
    static let enemy = PhysicsCategory(rawValue: 1 << 3)
    static let enemyBullet = PhysicsCategory(rawValue: 1 << 4)
    static let enemyBulletAttackable = PhysicsCategory(rawValue: 1 << 5)
    static let block = PhysicsCategory(rawValue: 1 << 6)
    static let blockAttackable = PhysicsCategory(rawValue: 1 << 7)
    static let edge = PhysicsCategory(rawValue: 1 << 8)
}
