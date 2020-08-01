//
//  Action.swift
//  Action
//
//  Created by Vladimir Psyukalov on 01.08.2020.
//  Copyright © 2020 Vladimir Psyukalov. All rights reserved.
//

import Foundation

public class Action {
    public let owner: Any
    
    public let targets: [Any]
    
    // MARK: - Init
    
    public init(owner: Any, targets: [Any] = []) {
        self.owner = owner
        self.targets = targets.isEmpty ? [owner] : targets
    }
    
    public func doAction() {
        /* Abstract. */
    }
}
