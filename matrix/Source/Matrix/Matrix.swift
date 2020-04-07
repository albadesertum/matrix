//
//  Matrix.swift
//  Matrix
//
//  Created by Vladimir Psyukalov on 20.01.2020.
//  Copyright © 2020 Vladimir Psyukalov. All rights reserved.
//

import Foundation

public class Matrix<T> {
    public let m: Int
    public let n: Int
    
    public private(set) var array: [T?]
    
    public var size: Int {
        return m * n
    }
    
    // MARK: - Init
    
    public init(m: Int, n: Int) {
        self.m = m
        self.n = n
        self.array = [T?](repeating: nil, count: m * n)
    }
    
    public convenience init(m: Int, n: Int, array: [T?]) {
        self.init(m: m, n: n)
        var index = 0
        forEach { i, j, _ in
            var value: T?
            if index < array.count {
                value = array[index]
            }
            self[i, j] = value
            index = index + 1
        }
    }
    
    public convenience init(m: Int, n: Int, elements: T...) {
        self.init(m: m, n: n, array: elements)
    }
    
    public convenience init(m: Int, n: Int, transposed: [T?]) {
        self.init(m: m, n: n)
        self.array = transposed
    }
    
    // MARK: - Subscript
    
    public subscript(index: Index?) -> T? {
        get {
            return self[index?.tuple]
        }
        set {
            self[index?.tuple] = newValue
        }
    }
    
    public subscript(tuple: (i: Int, j: Int)?) -> T? {
        get {
            return self[tuple?.i, tuple?.j]
        }
        set {
            self[tuple?.i, tuple?.j] = newValue
        }
    }
    
    public subscript(i: Int?, j: Int?) -> T? {
        get {
            if let index = index(i, j) {
                return array[index]
            }
            return nil
        }
        set {
            if let index = index(i, j) {
                array[index] = newValue
            }
        }
    }
    
    // MARK: - Public
    
    public func forEach(block: (_ i: Int, _ j: Int, _ value: T?) -> ()) {
        for i in 0..<m {
            for j in 0..<n {
                block(i, j, self[i, j])
            }
        }
    }
    
    public func forEachTuple(block: (_ tuple: (i: Int, j: Int), _ value: T?) -> ()) {
        forEach { i, j, value in
            block((i, j), value)
        }
    }
    
    public func forEachIndex(block: (_ index: Index, _ value: T?) -> ())  {
        forEachTuple { tuple, value in
            block(Index(tuple: tuple), value)
        }
    }
    
    // MARK: - Private
    
    private func index(_ i: Int?, _ j: Int?) -> Int? {
        guard let i = i, let j = j, isValid(i, j) else {
            return nil
        }
        return i + j * m
    }
    
    private func isValid(_ i: Int, _ j: Int) -> Bool {
        return i >= 0 && i < m && j >= 0 && j < n
    }
}
