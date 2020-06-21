//
//  ViewController.swift
//  test
//
//  Created by Vladimir Psyukalov on 18.03.2020.
//  Copyright © 2020 Vladimir Psyukalov. All rights reserved.
//

import UIKit
import SpriteKit
import matrix

class ViewController: UIViewController, UIGestureRecognizerDelegate {
    @IBOutlet weak var skView: SKView!
    
    var tap: UITapGestureRecognizer!
    var dTap: UITapGestureRecognizer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        tap = UITapGestureRecognizer(target: self, action: #selector(tapHandle(_:)))
//        dTap = UITapGestureRecognizer(target: self, action: #selector(dTapHandle(_:)))
//        dTap.numberOfTapsRequired = 2
//        tap.delegate = self
//        dTap.delegate = self
//        view.addGestureRecognizer(tap)
//        view.addGestureRecognizer(dTap)
        let a = ["a", "b", "c", "d", "e", "f", "g"]
        let mx = Matrix<Int>(m: 3, n: 3, elements: 0, 1, 2, 3, 4, 5, 6, 7, 8)
        let x = mx[0...3, 0...0]
        print(x)

        print(a[0...3])
        print(a.reduce("_", { $0 + $1 }))
    }
    
    @objc func tapHandle(_ sender: AnyObject?) {
        print("1")
    }
    
    @objc func dTapHandle(_ sender: AnyObject?) {
        print("2")
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        if gestureRecognizer == tap && otherGestureRecognizer == dTap {
            return true
        }
        return false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // let scene = MyScene(size: CGSize(width: 160.0, height: 160.0))
        let scene = TestScene(fileNamed: "MyScene")!
        scene.scaleMode = .aspectFill
        skView.presentScene(scene)
    }
}

class TestScene: SKScene {
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        guard let map = childNode(withName: "map1") as? SKTileMapNode else {
            return
        }
        let matrix = Matrix<Cell>(m: map.numberOfRows, n: map.numberOfColumns, repeating: Cell())
        try? matrix.sync(with: map, .plane) { value, userData in
            let isEmpty = userData?["isEmpty"] as? Bool ?? true
            value = isEmpty ? Cell() : Wall()
        }
        print("========")
        print(matrix)
    }
}

class Cell: Routable {
    var isEmpty: Bool {
        get {
            return true
        }
        set {}
    }
}

class Wall: Cell {
    override var isEmpty: Bool {
        get {
            return false
        }
        set {}
    }
}

class MyScene: SKScene, MovableDelegate {
    var matrix: Matrix<Cell>!
    
    let tileSize = CGSize(width: 16.0, height: 16.0)
    
    var main: Main!
    
    var targetIndex: Index?
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        let array = [
            Wall(), Wall(), Wall(), Wall(), Wall(), Wall(), Wall(), Wall(), Wall(), Wall(),
            Wall(), Cell(), Cell(), Wall(), Cell(), Cell(), Cell(), Wall(), Cell(), Wall(),
            Wall(), Cell(), Cell(), Wall(), Cell(), Cell(), Wall(), Wall(), Cell(), Wall(),
            Wall(), Cell(), Cell(), Wall(), Cell(), Wall(), Cell(), Wall(), Cell(), Wall(),
            Wall(), Cell(), Cell(), Wall(), Cell(), Cell(), Cell(), Wall(), Cell(), Wall(),
            Wall(), Cell(), Cell(), Wall(), Cell(), Cell(), Cell(), Wall(), Cell(), Wall(),
            Wall(), Cell(), Cell(), Wall(), Cell(), Cell(), Cell(), Wall(), Cell(), Wall(),
            Wall(), Cell(), Cell(), Wall(), Wall(), Wall(), Cell(), Wall(), Cell(), Wall(),
            Wall(), Cell(), Cell(), Cell(), Cell(), Cell(), Cell(), Wall(), Cell(), Wall(),
            Wall(), Wall(), Wall(), Wall(), Wall(), Wall(), Wall(), Wall(), Wall(), Wall()
        ]
        let x = SKShapeNode(circleOfRadius: 8.0)
        x.strokeColor = .yellow
        x.position = CGPoint(x: 0, y: 0)
        addChild(x)
        matrix = Matrix<Cell>(m: 10, n: 10, array: array)
        matrix.forEachIndex { index, value in
            if value?.isEmpty ?? false == false {
                let a = SKShapeNode(circleOfRadius: 8.0)
                a.position = point(by: index)
                a.fillColor = .blue
                addChild(a)
            }
        }
        main = Main(circleOfRadius: 8.0)
        main.strokeColor = .red
        main.movableDelegate = self
        addChild(main)
        main.position = point(by: Index(i: 1, j: 1))
    }
    
    func nodeDidFinishMove(_ node: SKNode) {
        print("finish move");
        targetIndex = nil
    }
    
    func p(_ a: [Index]?) {
        let res = Matrix<String>(m: matrix.m, n: matrix.n)
        res.forEachTuple { tuple, _ in
            if matrix[tuple]?.isEmpty ?? true {
                res[tuple] = a?.contains(Index(tuple: tuple)) ?? false ? " * " : "   "
            } else {
                res[tuple] = "[ ]"
            }
        }
        print(res)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            let indexA = index(by: main.position)
            let indexB = index(by: location)
            if let targetIndex = targetIndex, targetIndex == indexB {
                return
            }
            targetIndex = indexB
            var route = matrix.searchRoute(from: indexA, to: indexB)
            if main.hasActions() {
                route.removeFirst()
            }
            let points = route.map { point(by: $0) }
            main.move(with: points) { _ in
                
            }
        }
    }
    
    let geometry = Geometry.plane
    
    func point(by index: Index) -> CGPoint {
        return matrix.point(by: index, tileSize, geometry)
    }
    
    func index(by point: CGPoint) -> Index {
        return matrix.index(by: point, tileSize, geometry)
    }
}

public class Main: SKShapeNode, Movable {
    public var duration: TimeInterval {
        return 0.8
    }
    
    public var lenght: CGFloat {
        return 16.0
    }
    
    public weak var movableDelegate: MovableDelegate?
}
