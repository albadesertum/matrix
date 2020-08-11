//
//  Set+Common.swift
//  Set+Common
//
//  Created by Vladimir Psyukalov on 01.01.2020.
//  Copyright © 2020 Vladimir Psyukalov. All rights reserved.
//

import Foundation

public extension Set where Element: Hashable {
    
    var array: Array<Element> {
        return Array(self)
    }
}

extension Set: BooleanOperable where Element: Hashable {
    
    public typealias T = Set<Element>
    
    public static func >< (lhs: Set<Element>, rhs: Set<Element>) -> Set<Element> {
        return lhs.intersection(rhs)
    }
    
    public static func <> (lhs: Set<Element>, rhs: Set<Element>) -> Set<Element> {
        return lhs.symmetricDifference(rhs)
    }
    
    public static func <~ (lhs: Set<Element>, rhs: Set<Element>) -> Set<Element> {
        return (lhs <> rhs) >< lhs
    }
    
    public static func ~> (lhs: Set<Element>, rhs: Set<Element>) -> Set<Element> {
        return (lhs <> rhs) >< rhs
    }
}
