//
//  Matrix+Routable.swift
//  Matrix+Routable
//
//  Created by Vladimir Psyukalov on 20.01.2020.
//  Copyright © 2020 Vladimir Psyukalov. All rights reserved.
//

import Foundation

public extension Matrix where T: Routable {
    func searchRoute(from indexA: Index, to indexB: Index) -> [Index]? {
        var opened = [Node]()
        var closed = [Node]()
        let nodeA = Node(index: indexA, parent: nil, g: 0.0, h: 0.0)
        let nodeB = Node(index: indexB, parent: nil, g: 0.0, h: 0.0)
        opened.append(nodeA)
        while !opened.isEmpty {
            let current = opened.min { $0.f < $1.f }!
            if let index = opened.firstIndex(of: current) {
                opened.remove(at: index)
            }
            closed.append(current)
            if current == nodeB {
                return restoredRoute(from: current)
            }
            var childs = [Node]();
            let neighbors = [Index.up, .upRight, .right, .downRight, .down, .downLeft, .left, .upLeft]
            for neighbor in neighbors {
                let index = current.index + neighbor
                if let value = self[index], value.isEmpty, isDiagonal(from: current.index, to: index) {
                    let deltaA = index - current.index
                    let deltaB = index - nodeB.index
                    let g = current.g + deltaA.lenght
                    let h = deltaB.lenght
                    let node = Node(index: index, parent: current, g: g, h: h)
                    childs.append(node)
                }
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
    
    private func isDiagonal(from indexA: Index, to indexB: Index) -> Bool {
        let delta = indexA - indexB
        if delta.isZero {
            return true
        }
        var arrayA = [Index]()
        var arrayB = [Index]()
        let neighbors = [Index.up, .right, .down, .left]
        for neighbor in neighbors {
            arrayA.append(indexA + neighbor)
            arrayB.append(indexB + neighbor)
        }
        let setA = Set(arrayA)
        let setB = Set(arrayB)
        let intersections = Array(setA.intersection(setB))
        let valueA = self[intersections.first]?.isEmpty ?? true
        let valueB = self[intersections.last]?.isEmpty ?? true
        return valueA && valueB
    }
    
    private func restoredRoute(from node: Node?) -> [Index] {
        var route = [Index]()
        var current = node
        while current != nil {
            route.append(current!.index)
            current = current!.parent
        }
        return route.reversed()
    }
}
