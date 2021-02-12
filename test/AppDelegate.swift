//
//  AppDelegate.swift
//  test
//
//  Created by Vladimir Psyukalov on 18.03.2020.
//  Copyright © 2020 Vladimir Psyukalov. All rights reserved.
//

import UIKit
import MyLibrary
import matrix

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let a = Hello.init(text: "111")
//        let x = Hello.x
        print(a.text)
        let matrix = Matrix<Int>.init(m: 3, n: 3)
        matrix[0, 0] = 1
        matrix[2, 2] = 2
        print(matrix)
        let data = try? JSONEncoder().encode(matrix)
        print(data!)
        let json = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments)
        let djson = try? JSONSerialization.data(withJSONObject: json!, options: .fragmentsAllowed)
        let s = String.init(data: djson!, encoding: .utf8)
        print(json!)
        print(s!)
        let m2 = try? JSONDecoder().decode(Matrix<Int>.self, from: data!)
        print(m2!)
        return true
    }
}
