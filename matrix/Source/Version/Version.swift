//
//  Version.swift
//  Version
//
//  Created by Vladimir Psyukalov on 01.01.2020.
//  Copyright © 2020 Vladimir Psyukalov. All rights reserved.
//

import Foundation

public class Version {
    private static func value(at index: Int, in array: [Int]) -> Int {
        if index < array.count {
            return array[index]
        }
        return 0
    }
    
    public let string: String
    
    public let major: Int
    public let minor: Int
    public let patch: Int
    
    public init?(string: String) {
        let array = string.split(separator: ".").compactMap { Int(String($0)) }
        if array.isEmpty {
            return nil
        }
        self.string = string
        self.major = Version.value(at: 0, in: array)
        self.minor = Version.value(at: 1, in: array)
        self.patch = Version.value(at: 2, in: array)
    }
}
