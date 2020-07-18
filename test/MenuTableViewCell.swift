//
//  MenuTableViewCell.swift
//  MenuTableViewCell
//
//  Created by Vladimir Psyukalov on 01.01.2020.
//  Copyright © 2020 Vladimir Psyukalov. All rights reserved.
//

import UIKit

class MenuTableViewCell: UITableViewCell {
    @IBOutlet private weak var titleLabel: UILabel!
    
    public var title: String? {
        didSet {
            titleLabel.text = title
        }
    }
}
