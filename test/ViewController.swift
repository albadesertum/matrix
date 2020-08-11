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

class ViewController: UIViewController, UIGestureRecognizerDelegate, SingleGameButtonDelegate, DirectionsGameButtonDelegate {
    @IBOutlet weak var redButton: RedSingleGameButton!
    
    @IBOutlet weak var blueButton: BlueSingleGameButton!
    
    @IBOutlet weak var skView: SKView!
    
    @IBOutlet weak var directionButton: StandartDirectionsGameButton!
    
    var tap: UITapGestureRecognizer!
    var dTap: UITapGestureRecognizer!
//    @IBOutlet weak var p: ProgressView!
    
    func didPress(_ button: SingleGameButton) {
        if button == redButton {
            print("PRESS RED")
        }
        if button == blueButton {
            print("PRESS BLUE")
        }
    }
    
    func didRelease(_ button: SingleGameButton) {
        if button == redButton {
            print("RELEASE RED")
        }
        if button == blueButton {
            print("RELEASE BLUE")
        }
    }
    
    func didPress(_ button: DirectionsGameButton, at direction: DirectionsGameButton.Direction) {
        var str: String
        switch direction {
        case .none:
            str = "NONE"
        case .up:
            str = "UP"
        case .right:
            str = "RIGHT"
        case .down:
            str = "DOWN"
        case .left:
            str = "LEFT"
        }
        print("PRESS " + str)
    }
    
    func didRelease(_ button: DirectionsGameButton) {
        print("RELEASE DIR")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.setupGameButtons()
        redButton.delegate = self
        blueButton.delegate = self
        directionButton.delegate = self
//        let saveLoad = SaveLoad("my-save")
//        saveLoad.load()
//        print(saveLoad.list ?? ["nil" : "nil"])
//        saveLoad.list = ["some options" : 0]
//        saveLoad.save()
//        var mat = Matrix<Float>.init(m: 2, n: 2, transposed: [2.0, 3.0, 4.0, 6.0])
//        mat = mat * 2.0
//        print(mat)
//        print(mat[0...1, 1...1] * 3.0)
//        let chest1 = Chest(m: 2, n: 2, items: [Item(id: "0"), Item(id: "1"), Item(id: "2"), Item(id: "3")])
//        let chest2 = Chest(m: 2, n: 1, items: [Item(id: "4")])
//
//        print(chest1.items)
//        print(chest2.items)
//
//        let v1 = Version(string: "2.1.4")!
//        let v2 = Version(string: "2.1.3")!
//        print("v1 == v2 \(v1 == v2)")
//        print("v1 != v2 \(v1 != v2)")
//        print("v1 < v2 \(v1 < v2)")
//        print("v1 > v2 \(v1 > v2)")
//        print("v1 <= v2 \(v1 <= v2)")
//        print("v1 >= v2 \(v1 >= v2)")
//        queue.start()
        
//        let work1 = DispatchWorkItem {
//            self.p.set(progress: 0.5)
//        }
//        let work2 = DispatchWorkItem {
//            self.p.set(progress: 0.6)
//        }
//        let work3 = DispatchWorkItem {
//            self.p.set(progress: 0.0)
//        }
//        let work4 = DispatchWorkItem {
////            self.p.showDownloadButton()
//        }
//        let work5 = DispatchWorkItem {
//            self.p.set(progress: 0.9)
//        }
//        let work6 = DispatchWorkItem {
////            self.p.showPlayButton()
//        }
//
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: work1)
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: work2)
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: work3)
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: work4)
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: work5)
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: work6)
        
        
        
        //        tap = UITapGestureRecognizer(target: self, action: #selector(tapHandle(_:)))
        //        dTap = UITapGestureRecognizer(target: self, action: #selector(dTapHandle(_:)))
        //        dTap.numberOfTapsRequired = 2
        //        tap.delegate = self
        //        dTap.delegate = self
        //        view.addGestureRecognizer(tap)
        //        view.addGestureRecognizer(dTap)
        //        let a = ["a", "b", "c", "d", "e", "f", "g"]
        //        let mx = Matrix<Int>(m: 3, n: 3, elements: 0, 1, 2, 3, 4, 5, 6, 7, 8)
        //        let x = mx[0...3, 0...0]
        //        print(x)
        //
        //        print(a[0...3])
        //        print(a.reduce("_", { $0 + $1 }))
    }
    
    //    @objc func tapHandle(_ sender: AnyObject?) {
    //        print("1")
    //    }
    
    //    @objc func dTapHandle(_ sender: AnyObject?) {
    //        print("2")
    //    }
    
    //    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
    //        if gestureRecognizer == tap && otherGestureRecognizer == dTap {
    //            return true
    //        }
    //        return false
    //    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let scene = TestScene(fileNamed: "MyScene")!
        scene.scaleMode = .aspectFill
        skView.presentScene(scene)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        let x = MenuViewController()
//        let nc = UINavigationController(rootViewController: x)
//        nc.modalPresentationStyle = .fullScreen
//        present(nc, animated: true, completion: nil)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
}

class Cell: Routable {
    var isEmpty: Bool {
        return true
    }
}

class Wall: Cell {
    override var isEmpty: Bool {
        return false
    }
}

class TestScene: SKScene, MovableDelegate, DestroyableDelegate {
    var matrix: Matrix<Cell>!
    
    let tileSize = CGSize(width: 16.0, height: 16.0)
    
    var main: Main!
    
    var targetIndex: Index?
    
    var map: SKTileMapNode!
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        guard let map = childNode(withName: "map1") as? SKTileMapNode else {
            return
        }
        self.map = map
        matrix = Matrix<Cell>(m: map.numberOfRows, n: map.numberOfColumns)
        matrix.sync(with: map, .plane) { value, userData in
            let isEmpty = userData?["isEmpty"] as? Bool ?? true
            value = isEmpty ? Cell() : Wall()
        }
        main = Main(circleOfRadius: 8.0)
        main.strokeColor = .red
        main.movableDelegate = self
        addChild(main)
        main.position = point(by: Index(i: 1, j: 1))
//        let chest = Chest(m: 2, n: 2, items: [])
    }
    
    func nodeDidFinishMove(_ node: SKNode) {
        print("finish move")
        targetIndex = nil
    }
    
    func nodeDidDestroy(_ node: SKNode) {
        print("CHEST DESTROYED!!!")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: map)
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
            main.move(with: points)
        }
    }
    
    let geometry = Matrix<Cell>.Geometry.plane
    
    func point(by index: Index) -> CGPoint {
        return matrix.point(by: index, tileSize, geometry)
    }
    
    func index(by point: CGPoint) -> Index {
        return matrix.index(by: point, tileSize, geometry)
    }
}

public class Main: SKShapeNode, Movable {
    public var duration: TimeInterval {
        return 0.2
    }
    
    public var lenght: CGFloat {
        return 16.0
    }
    
    public weak var movableDelegate: MovableDelegate?
}

public class Queue {
    public private(set) var delay: Double
    
    public private(set) var isActive = false
    
    public private(set) var items = [DispatchWorkItem]()
    
    init(_ delay: Double = 0.2) {
        self.delay = delay
    }
    
    public func add(_ block: @escaping () -> Void) {
        let item = DispatchWorkItem {
            block()
            if !self.items.isEmpty {
                self.items.remove(at: 0)
                self.start(true)
            } else {
                self.isActive = false
            }
        }
        items.append(item)
        start(false)
    }
    
    private func start(_ force: Bool) {
        let isStart = force ? true : !isActive
        if isStart, let item = items.first {
            isActive = true
            DispatchQueue.main.asyncAfter(deadline: .now() + delay, execute: item)
        }
    }
}

class MainVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let item0 = UIBarButtonItem(image: UIImage(named: "icon_0"), style: .plain, target: nil, action: nil)
        let item1 = UIBarButtonItem(image: UIImage(named: "icon_1"), style: .plain, target: nil, action: nil)
        self.navigationItem.leftBarButtonItem = item0
        self.navigationItem.rightBarButtonItem = item1
    }
}
