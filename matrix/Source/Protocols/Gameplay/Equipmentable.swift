//
//  Equipmentable.swift
//  Equipmentable
//
//  Created by Vladimir Psyukalov on 01.01.2020.
//  Copyright © 2020 Vladimir Psyukalov. All rights reserved.
//

import Foundation

public protocol Equipmentable: class {
    
    var weapon: Equipment { get }
    
    var armor: Equipment { get }
    
    var artefact: Equipment { get }
}
