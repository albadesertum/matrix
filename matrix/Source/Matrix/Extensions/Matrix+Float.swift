//
//  Matrix+Float.swift
//  Matrix+Float
//
//  Created by Vladimir Psyukalov on 01.01.2020.
//  Copyright © 2020 Vladimir Psyukalov. All rights reserved.
//

import Foundation
import Accelerate

public extension Matrix where T == Float {
    
    static func * (lhs: T, rhs: Matrix) -> Matrix {
        var array = rhs.array
        let count = Int32(array.count)
        array.withUnsafeMutableBufferPointer { cblas_csscal(count, lhs, $0.baseAddress, 1) }
        return Matrix<T>(m: rhs.m, n: rhs.n, transposed: array)!
    }
    
    static func * (lhs: Matrix, rhs: T) -> Matrix {
        return rhs * lhs
    }
    
    static func * (lhs: Matrix, rhs: Matrix) throws -> Matrix {
        if lhs.m != rhs.n {
            throw MatrixError.multiplication
        }
        // TODO: Multiplicate two matrix of float.
        return lhs
    }
}
