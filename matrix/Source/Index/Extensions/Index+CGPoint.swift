//
//  Index+CGPoint.swift
//  Index+CGPoint
//
//  Created by Vladimir Psyukalov on 20.01.2020.
//  Copyright © 2020 Vladimir Psyukalov. All rights reserved.
//

import UIKit

public extension Index {
    var cgPoint: CGPoint {
        return CGPoint(x: j, y: i)
    }
}
