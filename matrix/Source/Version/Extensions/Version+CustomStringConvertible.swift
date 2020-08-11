//
//  Version+CustomStringConvertible.swift
//  Version+CustomStringConvertible
//
//  Created by Vladimir Psyukalov on 01.01.2020.
//  Copyright © 2020 Vladimir Psyukalov. All rights reserved.
//

import Foundation

extension Version: CustomStringConvertible {
    
    public var description: String {
        return string
    }
}
