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
    
    public var isBounded = false
    
    // MARK: - Override
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        isUserInteractionEnabled = true
        let longPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(longPressGestureRecognizerAction(_:)))
        longPressGestureRecognizer.minimumPressDuration = 0.0
        addGestureRecognizer(longPressGestureRecognizer)
    }
    
    // MARK: - Public
    
    public func didPress(at point: CGPoint) {
        isPressed = true
    }
    
    public func cancelDidChange(at point: CGPoint) -> Bool {
        return isBounded ? !bounds.contains(point) : false
    }
    
    public func didRelease(at point: CGPoint) {
        isPressed = false
    }
    
    // MARK: - Action
    
    @objc private func longPressGestureRecognizerAction(_ sender: UITapGestureRecognizer) {
        let point = sender.location(in: self)
        switch sender.state {
        case .began:
            didPress(at: point)
        case .changed:
            if cancelDidChange(at: point) {
                sender.state = .cancelled
            }
        default:
            didRelease(at: point)
        }
    }
}
