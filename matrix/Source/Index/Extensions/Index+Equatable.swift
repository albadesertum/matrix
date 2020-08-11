//
//  Index+Equatable.swift
//  Index+Equatable
//
//  Created by Vladimir Psyukalov on 01.01.2020.
//  Copyright © 2020 Vladimir Psyukalov. All rights reserved.
//

import Foundation

extension Index: Equatable {
    
    public static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.i == rhs.i && lhs.j == rhs.j
    }
}
