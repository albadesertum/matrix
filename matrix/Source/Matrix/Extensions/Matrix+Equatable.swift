//
//  Matrix+Equatable.swift
//  Matrix+Equatable
//
//  Created by Vladimir Psyukalov on 01.01.2020.
//  Copyright © 2020 Vladimir Psyukalov. All rights reserved.
//

import Foundation

public extension Matrix where T: Equatable {
    
    func firstIndex(of object: T?) -> Index? {
        if let tuple = firstTuple(of: object) {
            return Index(tuple: tuple)
        }
        return nil
    }
    
    func firstTuple(of object: T?) -> (i: Int, j: Int)? {
        if let index = array.firstIndex(of: object) {
            return (index % m, index / m)
        }
        return nil
    }
}
