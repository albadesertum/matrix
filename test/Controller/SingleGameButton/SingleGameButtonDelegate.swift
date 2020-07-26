//
//  SingleGameButtonDelegate.swift
//  SingleGameButtonDelegate
//
//  Created by Vladimir Psyukalov on 01.01.2020.
//  Copyright © 2020 Vladimir Psyukalov. All rights reserved.
//

import UIKit

public protocol SingleGameButtonDelegate: class {
    func didPress(_ button: SingleGameButton)
    func didRelease(_ button: SingleGameButton)
}
