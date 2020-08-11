//
//  BooleanOperable.swift
//  BooleanOperable
//
//  Created by Vladimir Psyukalov on 01.01.2020.
//  Copyright © 2020 Vladimir Psyukalov. All rights reserved.
//

import Foundation

infix operator >< // {A, B} >< {B, C, D} = {B}
infix operator <> // {A, B} <> {B, C, D} = {A, C, D}
infix operator <~ // {A, B} <~ {B, C, D} = {A}
infix operator ~> // {A, B} ~> {B, C, D} = {C, D}

public protocol BooleanOperable {
    
    associatedtype T
    
    static func >< (lhs: Self, rhs: Self) -> T
    static func <> (lhs: Self, rhs: Self) -> T
    static func <~ (lhs: Self, rhs: Self) -> T
    static func ~> (lhs: Self, rhs: Self) -> T
}
