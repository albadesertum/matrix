//
//  DirectionsGameButton.swift
//  DirectionsGameButton
//
//  Created by Vladimir Psyukalov on 01.01.2020.
//  Copyright © 2020 Vladimir Psyukalov. All rights reserved.
//

import UIKit

public class DirectionsGameButton: GameButton {
    public enum Direction {
        case none, up, right, down, left
    }
    
    public weak var delegate: DirectionsGameButtonDelegate?
    
    public var defaultImage: UIImage? {
        return nil
    }
    
    public var upImage: UIImage? {
        return nil
    }
    
    public var rightImage: UIImage? {
        return nil
    }
    
    public var downImage: UIImage? {
        return nil
    }
    
    public var leftImage: UIImage? {
        return nil
    }
    
    private var size: CGSize {
        let width = 1.0 / 3.0 * bounds.width
        let height = 1.0 / 3.0 * bounds.height
        return CGSize(width: width, height: height)
    }
    
    // MARK: - Override
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        applyImage(by: .none)
    }
    
    override public func didPress(at point: CGPoint) {
        if !isPressed {
            super.didPress(at: point)
            let directionValue = direction(by: point)
            applyImage(by: directionValue)
            delegate?.didPress(self, at: directionValue)
        }
    }
    
    override public func cancelDidChange(at point: CGPoint) -> Bool {
        let isCancelled = super.cancelDidChange(at: point)
        if !isCancelled {
            if direction(by: point) == .none {
                didRelease(at: point)
            } else {
                didPress(at: point)
            }
            return false
        }
        return true
    }
    
    override public func didRelease(at point: CGPoint) {
        if isPressed {
            super.didRelease(at: point)
            applyImage(by: .none)
            delegate?.didRelease(self)
        }
    }
    
    // MARK: - Private
    
    private func direction(by point: CGPoint) -> Direction {
        if frame(for: .up).contains(point) {
            return .up
        }
        if frame(for: .right).contains(point) {
            return .right
        }
        if frame(for: .down).contains(point) {
            return .down
        }
        if frame(for: .left).contains(point) {
            return .left
        }
        return .none
    }
    
    private func frame(for direction: Direction) -> CGRect {
        let size = self.size
        let width = size.width
        let height = size.height
        switch direction {
        case .none:
            return .zero
        case .up:
            return CGRect(x: 1.0 * width, y: 0.0 * height, width: width, height: height)
        case .right:
            return CGRect(x: 2.0 * width, y: 1.0 * height, width: width, height: height)
        case .down:
            return CGRect(x: 1.0 * width, y: 2.0 * height, width: width, height: height)
        case .left:
            return CGRect(x: 0.0 * width, y: 1.0 * height, width: width, height: height)
        }
    }
    
    private func applyImage(by direction: Direction) {
        switch direction {
        case .none:
            image = defaultImage
        case .up:
            image = upImage
        case .right:
            image = rightImage
        case .down:
            image = downImage
        case .left:
            image = leftImage
        }
    }
}
