//
//  PathGenerator.swift
//  RayBulletDemo
//
//  Created by mac on 2018/10/10.
//  Copyright © 2018年 cn17181. All rights reserved.
//

import Foundation
import UIKit

class PathGenerator: NSObject {

    static func randomQuadCurve(_ fromLoc:CGPoint, _ toLoc:CGPoint, ctlP:CGPoint) -> CGPath {
        let path = UIBezierPath()
        path.move(to: .zero)
        path.addQuadCurve(to: toLoc-fromLoc, controlPoint: ctlP)
        return path.cgPath
    }
}
