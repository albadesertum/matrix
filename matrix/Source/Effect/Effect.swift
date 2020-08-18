//
//  Effect.swift
//  Effect
//
//  Created by Vladimir Psyukalov on 01.01.2020.
//  Copyright © 2020 Vladimir Psyukalov. All rights reserved.
//

import Foundation

open class Effect {
    
    public enum Time {        
        case permanently, during(count: Int)
    }
    
    private var count: Int
    
    internal weak var sender: AnyObject?
    
    internal weak var receiver: AnyObject?
    
    open var time: Time {
        return .permanently
    }
    
    open var isApplied: Bool {
        return true
    }
    
    public var isCompleted: Bool {
        switch time {
        case .during(let count):
            return self.count == count
        default:
            return false
        }
    }
    
    // MARK: - Init
    
    public required init(sender: AnyObject?, receiver: AnyObject?) {
        self.count = 0
        self.sender = sender
        self.receiver = receiver
    }
    
    // MARK: - Public
    
    open func doEffect() {
        switch time {
        case .during:
            count = count + 1
        default:
            break
        }
    }
}
