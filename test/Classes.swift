//
//  Classes.swift
//  matrix
//
//  Created by Vladimir Psyukalov on 19.03.2020.
//  Copyright © 2020 Vladimir Psyukalov. All rights reserved.
//

import SpriteKit

public protocol MovableDelegate: class {
    func objectDidFinishMove(_ object: SKNode)
}

public protocol Movable: SKNode {
    var cellLenght: CGFloat { get }
    var rotateDuration: CGFloat { get }
    var moveDuration: CGFloat { get }
    
    var movableDelegate: MovableDelegate? { get }
    
    func moveDuration(from pointA: CGPoint, to pointB: CGPoint) -> CGFloat
    func rotateDuration(from pointA: CGPoint, to pointB: CGPoint) -> CGFloat
    
    func move(to point: CGPoint)
    func move(with points: [CGPoint])
}

public extension Movable {
    var cellLenght: CGFloat {
        get {
            return 16.0
        }
    }
    
    var rotateDuration: CGFloat {
        get {
            return 0.0
        }
    }
    
    var moveDuration: CGFloat {
        get {
            return 0.2
        }
    }
    
    func rotateAngle(from pointA: CGPoint, to pointB: CGPoint) -> CGFloat {
        return 0.0
    }
    
    func rotateDuration(from pointA: CGPoint, to pointB: CGPoint) -> CGFloat {
        return 0.0
    }
    
    func moveDuration(from pointA: CGPoint, to pointB: CGPoint) -> CGFloat {
        let distance = pointA.distance(to: pointB)
        if distance <= cellLenght {
            return distance * moveDuration / cellLenght
        } else {
            return moveDuration + (moveDuration - moveDuration * (distance - cellLenght) / cellLenght)
        }
    }
    
    func move(to point: CGPoint) {
        move(with: [point])
    }
    
    func move(with points: [CGPoint]) {
        if hasActions() {
            removeAllActions()
        }
        var actions = [SKAction]()
        var previousPoint = position
        for point in points {
            let angle = rotateAngle(from: previousPoint, to: point)
            let durationA = rotateDuration(from: previousPoint, to: point)
            let durationB = moveDuration(from: previousPoint, to: point)
            let rotate = SKAction.rotate(byAngle: angle, duration: Double(durationA))
            let move = SKAction.move(to: point, duration: Double(durationB))
            previousPoint = point
            actions.append(.group([rotate, move]))
        }
        run(.sequence(actions)) { [weak self] in
            if let self = self {
                self.movableDelegate?.objectDidFinishMove(self)
            }
        }
    }
}

public extension CGPoint {
    func distance(to point: CGPoint) -> CGFloat {
        let deltaX = x - point.x
        let deltaY = y - point.y
        return sqrt(deltaX * deltaX + deltaY * deltaY)
    }
}











public class Chest: Itemable {    
    public var id: String
    
    public var size: Int
    
    public var items: [Item]
    
    public init(id: String, size: Int, items: [Item]) {
        self.id = id
        self.size = size
        self.items = items
    }
}
