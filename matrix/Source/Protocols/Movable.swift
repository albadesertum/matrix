//
//  Movable.swift
//  Movable
//
//  Created by Vladimir Psyukalov on 01.01.2020.
//  Copyright © 2020 Vladimir Psyukalov. All rights reserved.
//

import SpriteKit

public protocol Movable: SKNode {
    var lenght: CGFloat { get }
    
    var duration: TimeInterval { get }
    
    var movableDelegate: MovableDelegate? { get }
    
    func duration(from pointA: CGPoint, to pointB: CGPoint) -> TimeInterval
    
    func move(to point: CGPoint, _ block: ((_ node: SKNode) -> ())?)
    
    func move(with points: [CGPoint], _ block: ((_ node: SKNode) -> ())?)
}

public extension Movable {
    func duration(from pointA: CGPoint, to pointB: CGPoint) -> TimeInterval {
        let distance = pointA.distance(to: pointB)
        let duration = CGFloat(self.duration)
        var result: CGFloat
        if distance <= lenght {
            result = duration * distance / lenght
        } else {
            result = duration + (duration - duration * (distance - lenght) / lenght)
        }
        return TimeInterval(result)
    }
    
    func move(to point: CGPoint, _ block: ((_ node: SKNode) -> ())? = nil) {
        move(with: [point], block)
    }
    
    func move(with points: [CGPoint], _ block: ((_ node: SKNode) -> ())? = nil) {
        if hasActions() {
            removeAllActions()
        }
        var actions = [SKAction]()
        var previousPoint = position
        for point in points {
            let duration = self.duration(from: previousPoint, to: point)
            actions.append(.move(to: point, duration: duration))
            previousPoint = point
        }
        run(.sequence(actions)) { [weak self] in
            guard let self = self else {
                return
            }
            block?(self)
            self.movableDelegate?.nodeDidFinishMove(self)
        }
    }
}
