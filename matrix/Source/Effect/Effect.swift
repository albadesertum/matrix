//
//  Effect.swift
//  Effect
//
//  Created by Vladimir Psyukalov on 01.01.2020.
//  Copyright © 2020 Vladimir Psyukalov. All rights reserved.
//

import Foundation

public class Effect {
    public enum Time {
        case permanently, during(count: Int)
    }
    
    internal weak var owner: Effectable?
    
    public var time: Time {
        return .permanently
    }
    
    private var count: Int
    
    public var isCompleted: Bool {
        switch time {
        case .during(let count):
            return self.count == count
        default:
            return false
        }
    }
    
    // MARK: - Init
    
    public required init(owner: Effectable?) {
        self.owner = owner
        self.count = 0
    }
    
    // MARK: - Public
    
    public func doEffect() {
        switch time {
        case .during:
            count = count + 1
        default:
            break
        }
    }
}
