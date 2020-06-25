//
//  Node.swift
//  Node
//
//  Created by Vladimir Psyukalov on 01.01.2020.
//  Copyright © 2020 Vladimir Psyukalov. All rights reserved.
//

import Foundation

public class Node {
    public var index: Index
    
    public var parent: Node?
    
    public var g: Float
    public var h: Float
    
    public var f: Float {
        return g + h
    }
        
    public init(index: Index, parent: Node?, g: Float, h: Float) {
        self.index = index
        self.parent = parent
        self.g = g
        self.h = h
    }
}
