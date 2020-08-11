//
//  Matrix+CustomStringConvertible.swift
//  Matrix+CustomStringConvertible
//
//  Created by Vladimir Psyukalov on 01.01.2020.
//  Copyright © 2020 Vladimir Psyukalov. All rights reserved.
//

import Foundation

extension Matrix: CustomStringConvertible {
    
    public var description: String {
        var result = "\(m) * \(n)\n"
        forEach { i, j, value in
            let index = Index(i: i, j: j)
            let stringValue = value == nil ? "nil" : "\(value!)"
            let lastCharacter = j < n - 1 ? " " : (i < m - 1 ? "\n" : "")
            result = result + "\(index.description) = \(stringValue);" + lastCharacter
        }
        return result
    }
}
