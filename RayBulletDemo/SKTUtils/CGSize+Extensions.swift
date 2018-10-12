//
//  CGSize+Extensions.swift
//  RayBulletDemo
//
//  Created by cn17181 on 2018/10/12.
//  Copyright © 2018 cn17181. All rights reserved.
//

import Foundation
import SpriteKit

extension CGSize {

}

/**
 * Adds two CGSize values and returns the result as a new CGSize.
 */
public func + (left: CGSize, right: CGSize) -> CGSize {
    return CGSize(width: left.width + right.width, height: left.height + right.height)
}

///**
// * Increments a CGSize with the value of another.
// */
//public func += (left: inout CGSize, right: CGSize) {
//    left = left + right
//}
//
///**
// * Subtracts two CGSize values and returns the result as a new CGSize.
// */
//public func - (left: CGSize, right: CGSize) -> CGSize {
//    return CGSize(dx: left.dx - right.dx, dy: left.dy - right.dy)
//}
//
///**
// * Decrements a CGSize with the value of another.
// */
//public func -= (left: inout CGSize, right: CGSize) {
//    left = left - right
//}
//
///**
// * Multiplies two CGSize values and returns the result as a new CGSize.
// */
//public func * (left: CGSize, right: CGSize) -> CGSize {
//    return CGSize(dx: left.dx * right.dx, dy: left.dy * right.dy)
//}
//
///**
// * Multiplies a CGSize with another.
// */
//public func *= (left: inout CGSize, right: CGSize) {
//    left = left * right
//}

/**
 * Multiplies the x and y fields of a CGSize with the same scalar value and
 * returns the result as a new CGSize.
 */
public func * (size: CGSize, scalar: CGFloat) -> CGSize {
    return CGSize(width: size.width * scalar, height: size.height * scalar)
}

///**
// * Multiplies the x and y fields of a CGSize with the same scalar value.
// */
//public func *= (vector: inout CGSize, scalar: CGFloat) {
//    vector = vector * scalar
//}

///**
// * Divides two CGSize values and returns the result as a new CGSize.
// */
//public func / (left: CGSize, right: CGSize) -> CGSize {
//    return CGSize(dx: left.dx / right.dx, dy: left.dy / right.dy)
//}
//
///**
// * Divides a CGSize by another.
// */
//public func /= (left: inout CGSize, right: CGSize) {
//    left = left / right
//}

/**
 * Divides the dx and dy fields of a CGSize by the same scalar value and
 * returns the result as a new CGSize.
 */
public func / (size: CGSize, scalar: CGFloat) -> CGSize {
    return CGSize(width: size.width / scalar, height: size.height / scalar)
}

/**
 * Divides the dx and dy fields of a CGSize by the same scalar value.
 */
//public func /= (vector: inout CGSize, scalar: CGFloat) {
//    vector = vector / scalar
//}
