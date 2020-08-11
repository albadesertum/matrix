//
//  Undo.swift
//  Undo
//
//  Created by Vladimir Psyukalov on 01.01.2020.
//  Copyright © 2020 Vladimir Psyukalov. All rights reserved.
//

import Foundation

public class Undo<T: Effect>: Action {
    
    override public func doAction() {
        for receiver in receivers {
            if let receiver = receiver as? Effectable {
                receiver.effects = receiver.effects.filter { !($0 is T) }
            }
        }
    }
}
