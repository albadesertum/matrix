//
//  Matrix.swift
//  Matrix
//
//  Created by Vladimir Psyukalov on 01.01.2020.
//  Copyright © 2020 Vladimir Psyukalov. All rights reserved.
//

import Foundation

public class Matrix<T: Codable>: Codable {
    
    public let m: Int
    public let n: Int
    
    public private(set) var array: [T?]
    
    public var size: Int {
        return m * n
    }
    
    public var isEmpty: Bool {
        return size == emptied
    }
    
    public var filled: Int {
        return size - emptied
    }
    
    public var emptied: Int {
        return array.filter { $0 == nil }.count
    }
    
    // MARK: - Init
    
    public init(m: Int, n: Int, repeating: T? = nil) {
        self.m = m
        self.n = n
        self.array = [T?](repeating: repeating, count: m * n)
    }
    
    public convenience init(m: Int, n: Int, array: [T?]) {
        self.init(m: m, n: n)
        var index = 0
        self.forEach { _, _, value in
            if index == array.count {
                return
            }
            value = array[index]
            index = index + 1
        }
    }
    
    public convenience init(m: Int, n: Int, elements: T?...) {
        self.init(m: m, n: n, array: elements)
    }
    
    public convenience init?(m: Int, n: Int, transposed: [T?]) {
        if m * n != transposed.count {
            return nil
        }
        self.init(m: m, n: n)
        self.array = transposed
    }
    
    // MARK: - Codable
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        self.m = try container.decode(Int.self, forKey: .m)
        self.n = try container.decode(Int.self, forKey: .n)
        self.array = try container.decode([T?].self, forKey: .array)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Keys.self)
        try container.encode(m, forKey: .m)
        try container.encode(n, forKey: .n)
        try container.encode(array, forKey: .array)
    }
    
    // MARK: - Subscript
    
    public subscript(index: Index) -> T? {
        get {
            return self[index.tuple]
        }
        set {
            self[index.tuple] = newValue
        }
    }
    
    public subscript(tuple: (i: Int, j: Int)) -> T? {
        get {
            return self[tuple.i, tuple.j]
        }
        set {
            self[tuple.i, tuple.j] = newValue
        }
    }
    
    public subscript(i: Int, j: Int) -> T? {
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
    
    public subscript(m: ClosedRange<Int>, n: ClosedRange<Int>) -> Matrix<T> {
        get {
            var transposed = [T?]()
            for i in m {
                for j in n {
                    transposed.append(self[i, j])
                }
            }
            return Matrix<T>(m: m.count, n: n.count, transposed: transposed)!
        }
    }
    
    // MARK: - Public
    
    public func forEach(_ block: (_ i: Int, _ j: Int, _ value: inout T?) -> ()) {
        for i in 0..<m {
            for j in 0..<n {
                block(i, j, &self[i, j])
            }
        }
    }
    
    public func forEachTuple(_ block: (_ tuple: (i: Int, j: Int), _ value: inout T?) -> ()) {
        forEach { i, j, value in
            block((i, j), &value)
        }
    }
    
    public func forEachIndex(_ block: (_ index: Index, _ value: inout T?) -> ())  {
        forEachTuple { tuple, value in
            block(Index(tuple: tuple), &value)
        }
    }
    
    // MARK: - Private
    
    private func index(_ i: Int, _ j: Int) -> Int? {
        if isValid(i, j) {
            return i + j * m
        }
        return nil
    }
    
    private func isValid(_ i: Int, _ j: Int) -> Bool {
        return 0 <= i && i < m && 0 <= j && j < n
    }
}
