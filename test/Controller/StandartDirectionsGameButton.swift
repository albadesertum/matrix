//
//  StandartDirectionsGameButton.swift
//  StandartDirectionsGameButton
//
//  Created by Vladimir Psyukalov on 01.01.2020.
//  Copyright © 2020 Vladimir Psyukalov. All rights reserved.
//

import UIKit

class StandartDirectionsGameButton: DirectionsGameButton {
    override public var defaultImage: UIImage? {
        return UIImage(named: "direction_buttons")
    }
    
    override public var upImage: UIImage? {
        return UIImage(named: "direction_buttons_up")
    }
    
    override public var rightImage: UIImage? {
        return UIImage(named: "direction_buttons_right")
    }
    
    override public var downImage: UIImage? {
        return UIImage(named: "direction_buttons_down")
    }
    
    override public var leftImage: UIImage? {
        return UIImage(named: "direction_buttons_left")
    }
}
