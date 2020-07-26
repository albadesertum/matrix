//
//  RedSingleGameButton.swift
//  RedSingleGameButton
//
//  Created by Vladimir Psyukalov on 01.01.2020.
//  Copyright © 2020 Vladimir Psyukalov. All rights reserved.
//

import UIKit

public class RedSingleGameButton: SingleGameButton {
    override public func awakeFromNib() {
        super.awakeFromNib()
        image = UIImage(named: "red_button")
        highlightedImage = UIImage(named: "red_button_highlighted")
    }
}
