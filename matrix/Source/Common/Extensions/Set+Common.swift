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

extension Set: BoolOperable where Element: Hashable {
    public typealias T = Set<Element>
    
    public func applyOperation(_ operation: BoolOperation, with elements: Set<Element>) -> Set<Element> {
        var result: Set<Element>
        switch operation {
        case .symmetricDifference:
            result = symmetricDifference(elements)
        case .leftDifference:
            let difference = symmetricDifference(elements)
            result = intersection(difference)
        case .rightDifference:
            let difference = symmetricDifference(elements)
            result = elements.intersection(difference)
        case .intersection:
            result = intersection(elements)
        }
        return result
    }
}
