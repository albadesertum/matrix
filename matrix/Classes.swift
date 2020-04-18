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

public protocol Itemable: SKNode {
    var items: [Item] { get set }
    
    func append(_ item: Item)
    func remove(_ item: Item)
}

public class Item {
    public var id: String
    
    public init(id: String) {
        self.id = id
    }
}

extension Item: Equatable {
    public static func == (lhs: Item, rhs: Item) -> Bool {
        return lhs.id == rhs.id
    }
}

extension Itemable {
    func append(_ item: Item) {
        items.append(item)
    }
    
    func remove(_ item: Item) {
        if let index = items.firstIndex(of: item) {
            items.remove(at: index)
        }
    }
}

public class Converter {
    private let m: Int
    private let n: Int
    
    private let cellSize: CGSize
    
    public init(m: Int, n: Int, cellSize: CGSize) {
        self.m = m
        self.n = n
        self.cellSize = cellSize
    }
    
    public func index(by point: CGPoint) -> Index {
        let i = m - Int(round(point.y / cellSize.height))
        let j = Int(round(point.x / cellSize.width))
        return Index(i: i, j: j)
    }
    
    public func point(by index: Index) -> CGPoint {
        let x = CGFloat(index.j) * cellSize.width
        let y = CGFloat(m - index.i) * cellSize.height
        return CGPoint(x: x, y: y)
    }
}
