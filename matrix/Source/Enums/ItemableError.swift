//
//  ItemableError.swift
//  ItemableError
//
//  Created by Vladimir Psyukalov on 01.01.2020.
//  Copyright © 2020 Vladimir Psyukalov. All rights reserved.
//

import Foundation

public enum ItemableError: Error {
    case notEnoughSpace(_ items: [Item]), notFound(_ items: [Item])
}
