//
//  Action.swift
//  Action
//
//  Created by Vladimir Psyukalov on 01.01.2020.
//  Copyright © 2020 Vladimir Psyukalov. All rights reserved.
//

import Foundation

open class Action {
    
    public let sender: AnyObject
    
    public let receivers: [AnyObject]
    
    // MARK: - Init
    
    public init(sender: AnyObject, receivers: [AnyObject] = []) {
        self.sender = sender
        self.receivers = receivers.isEmpty ? [sender] : receivers
    }
    
    open func doAction() {
        /* Abstract. */
    }
}
