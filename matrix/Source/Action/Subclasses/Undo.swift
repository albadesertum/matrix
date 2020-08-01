//
//  Undo.swift
//  Undo
//
//  Created by Vladimir Psyukalov on 01.08.2020.
//  Copyright © 2020 Vladimir Psyukalov. All rights reserved.
//

import Foundation

public class Undo<T: Effect>: Action {
    override public func doAction() {
        for target in targets {
            if let effectable = target as? Effectable {
                effectable.effects = effectable.effects.filter { $0 is T == false }
            }
        }
    }
}
