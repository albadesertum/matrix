//
//  Observable.swift
//  Observable
//
//  Created by Vladimir Psyukalov on 01.01.2020.
//  Copyright © 2020 Vladimir Psyukalov. All rights reserved.
//

import Foundation

public protocol Observable: class {
    
    var observers: [ObjectIdentifier : WeakReference] { get set }
}

public extension Observable {
    
    func addObserver(_ observer: AnyObject) {
        observers[ObjectIdentifier(observer.self)] = WeakReference(reference: observer)
    }
    
    func removeObserver(_ observer: AnyObject) {
        observers[ObjectIdentifier(observer.self)] = nil
    }
    
    func notify(_ block: (_ reference: AnyObject?) -> ()) {
        for (_, value) in observers {
            block(value.reference)
        }
    }
}
