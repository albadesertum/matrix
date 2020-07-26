//
//  DirectionsGameButtonDelegate.swift
//  DirectionsGameButtonDelegate
//
//  Created by Vladimir Psyukalov on 01.01.2020.
//  Copyright © 2020 Vladimir Psyukalov. All rights reserved.
//

import UIKit

public protocol DirectionsGameButtonDelegate: class {
    func didPress(_ button:DirectionsGameButton, at direction: DirectionsGameButton.Direction)
    func didRelease(_ button:DirectionsGameButton)
}
