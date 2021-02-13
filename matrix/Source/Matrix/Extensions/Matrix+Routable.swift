//
//  Matrix+Routable.swift
//  Matrix+Routable
//
//  Created by Vladimir Psyukalov on 01.01.2020.
//  Copyright © 2020 Vladimir Psyukalov. All rights reserved.
//

import SpriteKit

public extension Matrix where T: Routable {
    
    enum Geometry {
        
        case plane, isometry
    }
    
    func searchRoute(from indexA: Index, to indexB: Index) -> [Index] {
        var opened = [Node]()
        var closed = [Node]()
        let nodeA = Node(index: indexA, g: 0.0, h: 0.0)
        let nodeB = Node(index: indexB, g: 0.0, h: 0.0)
        opened.append(nodeA)
        while opened.isNotEmpty {
            let current = opened.min { $0.f < $1.f }!
            if let index = opened.firstIndex(of: current) {
                opened.remove(at: index)
            }
            closed.append(current)
            if current == nodeB {
                return restoreRoute(from: current)
            }
            var childs = [Node]()
            let indices = nearestEmptyIndices(from: current.index)
            for index in indices {
                let deltaA = index - current.index
                let deltaB = index - nodeB.index
                let g = current.g + deltaA.lenght
                let h = deltaB.lenght
                let node = Node(index: index, parent: current, g: g, h: h)
                childs.append(node)
            }
            for child in childs {
                if closed.firstIndex(of: child) != nil {
                    continue
                }
                if let index = opened.firstIndex(of: child), opened[index].f <= child.f {
                    continue
                }
                opened.append(child)
            }
        }
        let nearest = closed.min { ($0.index - indexB).lenght < ($1.index - indexB).lenght }!
        return searchRoute(from: indexA, to: nearest.index)
    }
    
    func nearestEmptyIndices(from index: Index) -> [Index] {
        var result = [Index]()
        let neighbors: [Index] = [.up, .upRight, .right, .downRight, .down, .downLeft, .left, .upLeft]
        for neighbor in neighbors {
            let neighborIndex = neighbor + index
            if let value = self[neighborIndex], value.isEmpty, isDiagonal(from: index, to: neighborIndex) {
                result.append(neighborIndex)
            }
        }
        return result
    }
    
    func index(by point: CGPoint, tileSize: CGSize, geometry: Geometry) -> Index {
        switch geometry {
        case .plane:
            let i = m - Int(round(point.y / tileSize.height))
            let j = Int(round(point.x / tileSize.width))
            return Index(i: i, j: j)
        case .isometry:
            // TODO: Index for isometry.
            return .zero
        }
    }
    
    func point(by index: Index, tileSize: CGSize, geometry: Geometry) -> CGPoint {
        switch geometry {
        case .plane:
            let x = CGFloat(index.j) * tileSize.width
            let y = CGFloat(m - index.i) * tileSize.height
            return CGPoint(x: x, y: y)
        case .isometry:
            // TODO: Point for isometry.
            return .zero
        }
    }
    
    func sync(with tileMapNode: SKTileMapNode, geometry: Geometry, block: (_ value: inout T?, _ userData: [String : Any]?) -> ()) {
        forEachIndex { index, value in
            let tileSize = tileMapNode.tileSize
            let wrongPoint = point(by: index, tileSize: tileSize, geometry: geometry)
            var point: CGPoint
            switch geometry {
            case .plane:
                point = CGPoint(x: wrongPoint.x + 0.5 * tileSize.width, y: wrongPoint.y - 0.5 * tileSize.height)
            case .isometry:
                // TODO: Sync for isometry.
                point = .zero
            }
            let column = tileMapNode.tileColumnIndex(fromPosition: point)
            let row = tileMapNode.tileRowIndex(fromPosition: point)
            let userData = tileMapNode.tileDefinition(atColumn: column, row: row)?.userData as? [String : Any]
            block(&value, userData)
        }
    }
    
    // MARK: - Private
    
    private func isDiagonal(from indexA: Index, to indexB: Index) -> Bool {
        let delta = indexA - indexB
        if delta.isAxis {
            return true
        }
        var arrayA = [Index]()
        var arrayB = [Index]()
        let neighbors: [Index] = [.up, .right, .down, .left]
        for neighbor in neighbors {
            arrayA.append(indexA + neighbor)
            arrayB.append(indexB + neighbor)
        }
        let intersections = arrayA >< arrayB
        let valueA = self[intersections[0]]?.isEmpty ?? true
        let valueB = self[intersections[1]]?.isEmpty ?? true
        return valueA && valueB
    }
    
    private func restoreRoute(from node: Node?) -> [Index] {
        var route = [Index]()
        var current = node
        while current != nil {
            route.append(current!.index)
            current = current!.parent
        }
        return route.reversed()
    }
}
