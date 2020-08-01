//
//  GameButton.swift
//  GameButton
//
//  Created by Vladimir Psyukalov on 01.01.2020.
//  Copyright © 2020 Vladimir Psyukalov. All rights reserved.
//

import UIKit

public class GameButton: UIImageView {
    public private(set) var isPressed: Bool = false
    
    // MARK: - Override
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        isUserInteractionEnabled = true
    }
    
    // MARK: - Public
    
    public func didPress(at point: CGPoint) {
        isPressed = true
    }
    
    public func cancelDidChange(at point: CGPoint) -> Bool {
        return false
    }
    
    public func didRelease(at point: CGPoint) {
        isPressed = false
    }
    
    @objc public func longPressGestureRecognizerAction(_ sender: UITapGestureRecognizer) {
        let point = sender.location(in: self)
        switch sender.state {
        case .began:
            if bounds.contains(point) {
                didPress(at: point)
            }
        case .changed:
            if cancelDidChange(at: point) {
                sender.state = .cancelled
            }
        default:
            didRelease(at: point)
        }
    }
}
