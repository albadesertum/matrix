//
//  Index+Hashable.swift
//  Index+Hashable
//
//  Created by Vladimir Psyukalov on 01.01.2020.
//  Copyright © 2020 Vladimir Psyukalov. All rights reserved.
//

import Foundation

extension Index: Hashable {
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(i)
        hasher.combine(j)
    }
}
