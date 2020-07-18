//
//  UITableView+Common.swift
//  UITableView+Common
//
//  Created by Vladimir Psyukalov on 01.01.2020.
//  Copyright © 2020 Vladimir Psyukalov. All rights reserved.
//

import UIKit

public extension UITableView {
    func register(_ type: UITableViewCell.Type) {
        let string = String(describing: type.self)
        let nib = UINib(nibName: string, bundle: nil)
        register(nib, forCellReuseIdentifier: string)
    }
}
