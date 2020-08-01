//
//  UIView+GameButton.swift
//  UIView+GameButton
//
//  Created by Vladimir Psyukalov on 01.01.2020.
//  Copyright © 2020 Vladimir Psyukalov. All rights reserved.
//

import UIKit

public extension UIView {
    func setupGameButtons() {
        let longPressGestureRecognizer = UILongPressGestureRecognizer()
        longPressGestureRecognizer.minimumPressDuration = 0.0
        longPressGestureRecognizer.cancelsTouchesInView = false
        addGestureRecognizer(longPressGestureRecognizer)
        for subview in subviews {
            if let gameButton = subview as? GameButton {
                longPressGestureRecognizer.addTarget(gameButton, action: #selector(gameButton.longPressGestureRecognizerAction(_:)))
            }
        }
    }
}
