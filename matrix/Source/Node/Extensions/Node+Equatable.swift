//
//  Node+Equatable.swift
//  Node+Equatable
//
//  Created by Vladimir Psyukalov on 01.01.2020.
//  Copyright © 2020 Vladimir Psyukalov. All rights reserved.
//

import Foundation

extension Node: Equatable {
    
    public static func == (lhs: Node, rhs: Node) -> Bool {
        return lhs.index == rhs.index
    }
}
