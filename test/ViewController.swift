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
        Sorceror().test()
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

class Cell: Routable, Codable {
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
        matrix.sync(with: map, geometry: .plane) { _, _ in
            
        }
        matrix.sync(with: map, geometry: .plane) { value, userData in
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
        return matrix.point(by: index, tileSize: tileSize, geometry: geometry)
    }
    
    func index(by point: CGPoint) -> Index {
        return matrix.index(by: point, tileSize: tileSize, geometry: geometry)
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
    @IBOutlet weak var slider: HandmadeSlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let item0 = UIBarButtonItem(image: UIImage(named: "icon_0"), style: .plain, target: nil, action: nil)
        let item1 = UIBarButtonItem(image: UIImage(named: "icon_1"), style: .plain, target: nil, action: nil)
        self.navigationItem.leftBarButtonItem = item0
        self.navigationItem.rightBarButtonItem = item1
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        slider.setValue(1.0, animated: true)
    }
    
    @IBAction func vc(_ sender: HandmadeSlider) {
        print(sender.value)
    }
}

class TestVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var test: UIStackView!
    
    var s: Sorceror!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        s = Sorceror()
        s.test()
        
        if #available(iOS 13.0, *) {
            let interaction = UIContextMenuInteraction(delegate: self)
            //            imageView.addInteraction(interaction)
            test.addInteraction(interaction)
        } else {
            
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "\(indexPath)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        present(datePickerViewController()!, animated: true, completion: nil)
    }
    
    private func datePickerViewController() -> AlertVC? {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "AlertVC")
        let ratio = 0.8
        let width = UIScreen.main.bounds.width
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle = .crossDissolve
        vc.preferredContentSize = CGSize(width: CGFloat(ratio) * width, height: 256.0)
        return vc as? AlertVC
    }
}

class AlertVC: UIViewController {
    
}

@available(iOS 13.0, *)
extension TestVC: UIContextMenuInteractionDelegate {
    func contextMenuInteraction(_ interaction: UIContextMenuInteraction, configurationForMenuAtLocation location: CGPoint) -> UIContextMenuConfiguration? {
        let configuration = UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { _ in
            let test = UIAction(title: "Test", image: nil) { _ in
                print("test!")
            }
            let test2 = UIAction(title: "Test 2", image: nil) { _ in
                print("test! 2")
            }
            return UIMenu(title: "Menu", image: nil, children: [test, test2])
        }
        return configuration
    }
}

class ChatTextView: UIView {
    
    private let placeholderLabel = UILabel()
    
    let textView = UITextView()
    
    private var heightConstraint: NSLayoutConstraint?
    
    var text: String? {
        get {
            return textView.text
        }
        set {
            textView.text = newValue
            applyHeight()
            applyPlaceholderLabel()
        }
    }
    
    var placeholder: String? {
        get {
            return placeholderLabel.text
        }
        set {
            placeholderLabel.text = newValue
        }
    }
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    // MARK: - Private
    
    private func setup() {
        setupTextView()
        setupPlaceholderLabel()
        text = nil
        backgroundColor = .clear
        NotificationCenter.default.addObserver(self, selector: #selector(UITextInputDelegate.textDidChange(_:)), name: UITextView.textDidChangeNotification, object: textView)
        placeholder = "Long placeholder text, very long! I'm not joking!"
    }
    
    private func setupTextView() {
        textView.backgroundColor = .clear
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = UIFont.systemFont(ofSize: 15.0)
//        textView.contentInset = .zero
//        textView.textContainerInset = .zero
        addSubview(textView)
        addConstraint(NSLayoutConstraint(item: self, attribute: .left, relatedBy: .equal, toItem: textView, attribute: .left, multiplier: 1.0, constant: 0.0))
        addConstraint(NSLayoutConstraint(item: self, attribute: .right, relatedBy: .equal, toItem: textView, attribute: .right, multiplier: 1.0, constant: 0.0))
        addConstraint(NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: textView, attribute: .top, multiplier: 1.0, constant: 0.0))
        addConstraint(NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: textView, attribute: .bottom, multiplier: 1.0, constant: 0.0))
        heightConstraint = NSLayoutConstraint.init(item: textView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 32.0)
        textView.addConstraint(heightConstraint!)
    }
    
    private func setupPlaceholderLabel() {
        placeholderLabel.numberOfLines = 1
        placeholderLabel.backgroundColor = .clear
        placeholderLabel.lineBreakMode = .byTruncatingTail
        placeholderLabel.font = UIFont.systemFont(ofSize: 15.0)
        placeholderLabel.textColor = UIColor(red: 0.38, green: 0.38, blue: 0.38, alpha: 1.0)
        placeholderLabel.isUserInteractionEnabled = false
        placeholderLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(placeholderLabel)
        addConstraint(NSLayoutConstraint(item: self, attribute: .left, relatedBy: .equal, toItem: placeholderLabel, attribute: .left, multiplier: 1.0, constant: -6.0))
        addConstraint(NSLayoutConstraint(item: self, attribute: .right, relatedBy: .greaterThanOrEqual, toItem: placeholderLabel, attribute: .right, multiplier: 1.0, constant: 0.0))
        addConstraint(NSLayoutConstraint(item: self, attribute: .centerY, relatedBy: .equal, toItem: placeholderLabel, attribute: .centerY, multiplier: 1.0, constant: 0.0))
    }
    
    private func applyPlaceholderLabel() {
        let text = self.text ?? ""
        placeholderLabel.isHidden = !text.isEmpty
    }
    
    private func applyHeight() {
        textChanged()
        let label = UILabel()
        label.font = textView.font
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.text = text
        label.sizeToFit()
        let size = textView.sizeThatFits(CGSize.init(width: textView.frame.width/* - textView.textContainerInset.top - textView.textContainerInset.bottom*/, height: .greatestFiniteMagnitude))
        heightConstraint?.constant = size.height < 32.0 ? 32.0 : (size.height/* + textView.textContainerInset.top + textView.textContainerInset.bottom*/)
    }
    
    func textChanged() {
        let caretRect = textView.caretRect(for: textView.selectedTextRange!.start)
        let overflow = caretRect.size.height + caretRect.origin.y - (textView.contentOffset.y + textView.bounds.size.height - textView.contentInset.bottom - textView.contentInset.top)
        if overflow > 0 {
            //Fix wrong offset when cursor jumps to next line un explisitly
            let seekEndY = textView.contentSize.height - textView.bounds.size.height
            if textView.contentOffset.y != seekEndY {
                textView.contentOffset.y = seekEndY
            }
        }
    }
    
    // MARK: - objc
    
    @objc private func textDidChange(_ note: Notification) {
        applyHeight()
        applyPlaceholderLabel()
    }
}

@objc public protocol GrowingTextViewDelegate: UITextViewDelegate {
    @objc optional func textViewDidChangeHeight(_ textView: GrowingTextView, height: CGFloat)
}

@IBDesignable @objc
open class GrowingTextView: UITextView {
    override open var text: String! {
        didSet { setNeedsDisplay() }
    }
    private var heightConstraint: NSLayoutConstraint?
    
    // Maximum length of text. 0 means no limit.
    @IBInspectable open var maxLength: Int = 0
    
    // Trim white space and newline characters when end editing. Default is true
    @IBInspectable open var trimWhiteSpaceWhenEndEditing: Bool = true
    
    // Customization
    @IBInspectable open var minHeight: CGFloat = 0 {
        didSet { forceLayoutSubviews() }
    }
    @IBInspectable open var maxHeight: CGFloat = 0 {
        didSet { forceLayoutSubviews() }
    }
    @IBInspectable open var placeholder: String? {
        didSet { setNeedsDisplay() }
    }
    @IBInspectable open var placeholderColor: UIColor = UIColor(white: 0.8, alpha: 1.0) {
        didSet { setNeedsDisplay() }
    }
    @IBInspectable open var attributedPlaceholder: NSAttributedString? {
        didSet { setNeedsDisplay() }
    }
    
    // Initialize
    override public init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        commonInit()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        contentMode = .redraw
        associateConstraints()
        NotificationCenter.default.addObserver(self, selector: #selector(textDidChange), name: UITextView.textDidChangeNotification, object: self)
        NotificationCenter.default.addObserver(self, selector: #selector(textDidEndEditing), name: UITextView.textDidEndEditingNotification, object: self)
        placeholder = "Long placeholder text, very long! I'm not joking!"
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    open override var intrinsicContentSize: CGSize {
        return CGSize(width: UIView.noIntrinsicMetric, height: 30)
    }
    
    private func associateConstraints() {
        // iterate through all text view's constraints and identify
        // height,from: https://github.com/legranddamien/MBAutoGrowingTextView
        for constraint in constraints {
            if (constraint.firstAttribute == .height) {
                if (constraint.relation == .equal) {
                    heightConstraint = constraint;
                }
            }
        }
    }
    
    // Calculate and adjust textview's height
    private var oldText: String = ""
    private var oldSize: CGSize = .zero
    
    private func forceLayoutSubviews() {
        oldSize = .zero
        setNeedsLayout()
        layoutIfNeeded()
    }
    
    private var shouldScrollAfterHeightChanged = false
    override open func layoutSubviews() {
        super.layoutSubviews()
        
        if text == oldText && bounds.size == oldSize { return }
        oldText = text
        oldSize = bounds.size
        
        let size = sizeThatFits(CGSize(width: bounds.size.width, height: CGFloat.greatestFiniteMagnitude))
        var height = size.height
        
        // Constrain minimum height
        height = minHeight > 0 ? max(height, minHeight) : height
        
        // Constrain maximum height
        height = maxHeight > 0 ? min(height, maxHeight) : height
        
        // Add height constraint if it is not found
        if (heightConstraint == nil) {
            heightConstraint = NSLayoutConstraint(item: self, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: height)
            addConstraint(heightConstraint!)
        }
        
        // Update height constraint if needed
        if height != heightConstraint!.constant {
            shouldScrollAfterHeightChanged = true
            heightConstraint!.constant = height
            if let delegate = delegate as? GrowingTextViewDelegate {
                delegate.textViewDidChangeHeight?(self, height: height)
            }
        } else if shouldScrollAfterHeightChanged {
            shouldScrollAfterHeightChanged = false
            scrollToCorrectPosition()
        }
    }
    
    private func scrollToCorrectPosition() {
        if self.isFirstResponder {
            self.scrollRangeToVisible(NSMakeRange(-1, 0)) // Scroll to bottom
        } else {
            self.scrollRangeToVisible(NSMakeRange(0, 0)) // Scroll to top
        }
    }
    
    // Show placeholder if needed
    override open func draw(_ rect: CGRect) {
        super.draw(rect)
        
        if text.isEmpty {
            let xValue = textContainerInset.left + textContainer.lineFragmentPadding
            let yValue = textContainerInset.top
            let width = rect.size.width - xValue - textContainerInset.right
            let height = rect.size.height - yValue - textContainerInset.bottom
            let placeholderRect = CGRect(x: xValue, y: yValue, width: width, height: height)
            
            if let attributedPlaceholder = attributedPlaceholder {
                // Prefer to use attributedPlaceholder
                attributedPlaceholder.draw(in: placeholderRect)
            } else if let placeholder = placeholder {
                // Otherwise user placeholder and inherit `text` attributes
                let paragraphStyle = NSMutableParagraphStyle()
                paragraphStyle.alignment = textAlignment
                var attributes: [NSAttributedString.Key: Any] = [
                    .foregroundColor: placeholderColor,
                    .paragraphStyle: paragraphStyle
                ]
                if let font = font {
                    attributes[.font] = font
                }
                
                placeholder.draw(in: placeholderRect, withAttributes: attributes)
            }
        }
    }
    
    // Trim white space and new line characters when end editing.
    @objc func textDidEndEditing(notification: Notification) {
        if let sender = notification.object as? GrowingTextView, sender == self {
            if trimWhiteSpaceWhenEndEditing {
                text = text?.trimmingCharacters(in: .whitespacesAndNewlines)
                setNeedsDisplay()
            }
            scrollToCorrectPosition()
        }
    }
    
    // Limit the length of text
    @objc func textDidChange(notification: Notification) {
        if let sender = notification.object as? GrowingTextView, sender == self {
            if maxLength > 0 && text.count > maxLength {
                let endIndex = text.index(text.startIndex, offsetBy: maxLength)
                text = String(text[..<endIndex])
                undoManager?.removeAllActions()
            }
            setNeedsDisplay()
        }
    }
}
