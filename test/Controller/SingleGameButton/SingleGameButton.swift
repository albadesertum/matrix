//
//  SingleGameButton.swift
//  SingleGameButton
//
//  Created by Vladimir Psyukalov on 01.01.2020.
//  Copyright © 2020 Vladimir Psyukalov. All rights reserved.
//

import UIKit

public class SingleGameButton: GameButton {
    public weak var delegate: SingleGameButtonDelegate?
    
    override public func didPress(at point: CGPoint) {
        if !isPressed {
            super.didPress(at: point)
            isHighlighted = true
            delegate?.didPress(self)
        }
    }
    
    override public func cancelDidChange(at point: CGPoint) -> Bool {
        let isCancelled = super.cancelDidChange(at: point)
        if !isCancelled {
            if bounds.contains(point) {
                didPress(at: point)
            } else {
                didRelease(at: point)
            }
            return false
        }
        return true
    }
    
    override public func didRelease(at point: CGPoint) {
        if isPressed {
            super.didRelease(at: point)
            isHighlighted = false
            delegate?.didRelease(self)
        }
    }
}
