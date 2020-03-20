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
            let tuples = [(-1, 0), (-1, 1), (0, 1), (1, 1), (1, 0), (1, -1), (0, -1), (-1, -1)]
            var childs = [Node]();
            for tuple in tuples {
                let index = current.index + tuple
                if let value = self[index], value.isEmpty, isDiagonal(from: current.index, to: index) {
                    let deltaX = index - current.index
                    let deltaY = index - nodeB.index
                    let g = current.g + deltaX.lenght
                    let h = deltaY.lenght
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
        return nil
    }
    
    private func isDiagonal(from indexA: Index, to indexB: Index) -> Bool {
        let delta = indexA - indexB
        if delta.haveZero {
            return true
        }
        let tuples = [(-1, 0), (0, 1), (1, 0), (0, -1)]
        var arrayA = [Index]()
        var arrayB = [Index]()
        for tuple in tuples {
            let temp = Index(tuple: tuple)
            arrayA.append(indexA + temp)
            arrayB.append(indexB + temp)
        }
        let setA = Set(arrayA)
        let setB = Set(arrayB)
        let intersection = setA.intersection(setB)
        let valueX = self[Array(intersection)[0]]?.isEmpty ?? true
        let valueY = self[Array(intersection)[1]]?.isEmpty ?? true
        return valueX && valueY
    }
    
    private func restoredRoute(from node: Node?) -> [Index] {
        var route = [Index]()
        var temp = node
        while temp != nil {
            route.append(temp!.index)
            temp = temp!.parent
        }
        return route.reversed()
    }
}
