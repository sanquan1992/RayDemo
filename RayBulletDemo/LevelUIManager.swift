//
//  LevelUIManager.swift
//  RayBulletDemo
//
//  Created by cn17181 on 2018/10/12.
//  Copyright © 2018 cn17181. All rights reserved.
//

import Foundation
import SpriteKit

protocol BGTexture {
    
    func textures() -> [SKTexture]
    func speeds() -> [CGFloat]
}

enum NormalLevelEnum: BGTexture {
    case City
    case Sea
    case Space
    case Desert
    case Forest
    case Unknown
    
    func textures() -> [SKTexture] {
        switch self {
        case .City:
            let overlay0 = "Background"
            let overlay1 = "Foreground"
            return [SKTexture.init(imageNamed: overlay0),
                    SKTexture.init(imageNamed: overlay1)]
        default:
            return []
        }
    }
    
    func speeds() -> [CGFloat] {
        //Speed max value '1.0', not control with pixel
        //TODO: later will change with content
        return [0.125, 0.3]
    }
}

enum BossLevelEnum: BGTexture {
    
    case King
    
    func textures() -> [SKTexture] {
        switch self {
        case .King:
            let overlay0 = ""
            let overLay1 = ""
            return [SKTexture.init(imageNamed: overlay0),
                    SKTexture.init(imageNamed: overLay1)]
        default:
            return []
        }
    }
    
    func speeds() -> [CGFloat] {
        return [0.125, 0.5]
    }
}

enum BonusLevelEnum: BGTexture {
    case CoinCollect
    case SkillChallenge
    
    func textures() -> [SKTexture] {
        switch self {
        case .CoinCollect:
            let overlay0 = ""
            let overLay1 = ""
            return [SKTexture.init(imageNamed: overlay0),
                    SKTexture.init(imageNamed: overLay1)]
        default:
            return []
        }
    }
    
    func speeds() -> [CGFloat] {
        return [0.25, 0.7]
    }
}


enum LevelEnum {
    
    case Normallevel(level:NormalLevelEnum)
    case BossLevel(level:BossLevelEnum)
    case BonusLevel(level:BonusLevelEnum)
    
    func texturesFromBackToFore() -> [SKTexture] {
        switch self {
        case .Normallevel(let level):
            return level.textures()
        case .BossLevel(let level):
            return level.textures()
        case .BonusLevel(let level):
            return level.textures()
        }
    }
    
    func speeds() -> [CGFloat] {
        switch self {
        case .Normallevel(let level):
            return level.speeds()
        case .BossLevel(let level):
            return level.speeds()
        case .BonusLevel(let level):
            return level.speeds()
        }
    }
}

class LevelUIManager {
    
    static var outSprite = [[SKSpriteNode]]()
    static var outSpeeds = [CGFloat]()
    static var playAera:CGRect = .zero
    
    static func ready(_ level:LevelEnum, on scene:SKScene, playableAera:CGRect, _ baseSpeed:CGFloat = 2000 /* 单位 pixel */) {
        
        playAera = playableAera
        //Clear
        var sprites = outSprite.flatMap {
            $0.map { $0.removeFromParent() }
        }
        outSpeeds.removeAll()
        sprites.removeAll()
        outSprite.removeAll()
        
        //Ready new
        let textures = level.texturesFromBackToFore()
        let speeds = level.speeds()
        guard speeds.count == textures.count else {
            fatalError("Important error : BG texture's count is not adopt to speed's count")
        }
        for i in 0..<textures.count {
            let texture = textures[i]
            let speed = speeds[i] * baseSpeed
            let sprite = SKSpriteNode.init(texture: texture, size: playableAera.size)
            sprite.anchorPoint = .zero
            let nextSprite = sprite.copy() as! SKSpriteNode
            sprite.position = playableAera.origin
            nextSprite.position = CGPoint(x: sprite.size.width + playableAera.origin.x, y: sprite.position.y)
            scene.addChild(sprite)
            scene.addChild(nextSprite)
            sprite.zPosition = -40 + CGFloat(i)
            nextSprite.zPosition = sprite.zPosition
            outSprite.append([sprite, nextSprite])
            outSpeeds.append(speed)
            
            print("UI Info: add bg info: \(sprite.anchorPoint), \(nextSprite.anchorPoint)")
        }
    }
    
    static func run(dt: TimeInterval) {
        
        guard outSprite.count > 0, outSpeeds.count > 0 else {
            fatalError("UI Error: bg resource loading failed")
        }
        var newPos = CGPoint.zero
        for i in 0..<outSprite.count {
            let overlay = outSprite[i]
            for j in 0..<overlay.count {
                let spriteMove = overlay[j]
                newPos = spriteMove.position
                newPos.x -= outSpeeds[i] * CGFloat(dt)
                spriteMove.position = newPos
                
                if spriteMove.frame.maxX < playAera.minX {
                    spriteMove.position = CGPoint.init(x: spriteMove.position.x + spriteMove.size.width * 2.0, y: spriteMove.position.y)
                }
            }
        }
    }
}
