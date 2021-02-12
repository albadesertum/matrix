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
    
    public init?(major: Int, minor: Int, patch: Int) {
        if major < 0 || minor < 0 || patch < 0 {
            return nil
        }
        self.string = "\(major).\(minor).\(patch)"
        self.major = major
        self.minor = minor
        self.patch = patch
    }
    
    public convenience init?(string: String) {
        let array = string.split(separator: ".").compactMap { Int(String($0)) }
        if array.isEmpty {
            return nil
        }
        let major = Version.value(at: 0, in: array)
        let minor = Version.value(at: 1, in: array)
        let patch = Version.value(at: 2, in: array)
        self.init(major: major, minor: minor, patch: patch)
    }
}
