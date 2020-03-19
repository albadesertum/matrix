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
    var rotateSpeed: Double { get }
    var moveSpeed: Double { get }
    
    var movableDelegate: MovableDelegate? { get set }
    
    func move(by points: [CGPoint]?)
}

public extension Movable {
    func move(by points: [CGPoint]?) {
        guard let points = points else {
            return
        }
        if hasActions() {
            removeAllActions()
            move(by: [.zero] + points)
        } else {
            var actions = [SKAction]()
            var previousPoint = position
            for point in points.dropFirst() {
//                let angle: CGFloat = 0.0
//                let rotate = SKAction.rotate(toAngle: angle, duration: rotateSpeed, shortestUnitArc: true)
                let move = SKAction.move(to: point, duration: moveSpeed)
//                actions.append(.group([rotate, move]))
                actions.append(move)
                previousPoint = point
            }
            run(.sequence(actions)) { [weak self] in
                if let self = self {
                    self.movableDelegate?.objectDidFinishMove(self)
                }
            }
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
        let i = m - Int(point.y / cellSize.height)
        let j = Int(point.x / cellSize.width)
        return Index(i: i, j: j)
    }
    
    public func point(by index: Index) -> CGPoint {
        let x = CGFloat(index.j) * cellSize.width
        let y = CGFloat(m - index.i) * cellSize.height
        return CGPoint(x: x, y: y)
    }
}

//

//let delta = index - previousIndex
//let x = CGFloat(index.j) * cellSize.height
//let y = (mapSize.height - CGFloat(index.i)) * cellSize.height

//var currentIndex: Index {
//    let i = Int(mapSize.height) - Int(position.y / cellSize.height)
//    let j = Int(position.x / cellSize.width)
//    return Index(i: i, j: j)
//}
