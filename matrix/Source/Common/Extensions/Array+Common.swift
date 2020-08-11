//
//  Array+Common.swift
//  Array+Common
//
//  Created by Vladimir Psyukalov on 01.01.2020.
//  Copyright © 2020 Vladimir Psyukalov. All rights reserved.
//

import Foundation

public extension Array {
    
    var isNotEmpty: Bool {
        return !isEmpty
    }
    
    func isExist(_ index: Int) -> Bool {
        return 0 <= index && index < count
    }
    
    func isNotExist(_ index: Int) -> Bool {
        return !isExist(index)
    }
}

extension Array where Element: Hashable {
    
    var set: Set<Element> {
        return Set(self)
    }
}

extension Array: BooleanOperable where Element: Hashable {
    
    public typealias T = Array<Element>
    
    public static func >< (lhs: Array<Element>, rhs: Array<Element>) -> Array<Element> {
        return (lhs.set >< rhs.set).array
    }
    
    public static func <> (lhs: Array<Element>, rhs: Array<Element>) -> Array<Element> {
        return (lhs.set <> rhs.set).array
    }
    
    public static func <~ (lhs: Array<Element>, rhs: Array<Element>) -> Array<Element> {
        return (lhs.set <~ rhs.set).array
    }
    
    public static func ~> (lhs: Array<Element>, rhs: Array<Element>) -> Array<Element> {
        return (lhs.set ~> rhs.set).array
    }
}
