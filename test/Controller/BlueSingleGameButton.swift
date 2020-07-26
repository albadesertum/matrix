//
//  BlueSingleGameButton.swift
//  BlueSingleGameButton
//
//  Created by Vladimir Psyukalov on 01.01.2020.
//  Copyright © 2020 Vladimir Psyukalov. All rights reserved.
//

import UIKit

public class BlueSingleGameButton: SingleGameButton {
    override public func awakeFromNib() {
        super.awakeFromNib()
        image = UIImage(named: "blue_button")
        highlightedImage = UIImage(named: "blue_button_highlighted")
    }
}
