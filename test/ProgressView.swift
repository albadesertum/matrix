import UIKit

class ProgressView: UIButton {
	
	enum ProgressType {
		case determinate
		case indeterminate
	}
	
	enum Icon {
		case none
		case stop
		case download
		case upload
		case play
	}
	
	// MARK: - Layers
	private let backgroundLayer = CAShapeLayer()
	private let circleLayer = CAShapeLayer()
	private var closeLayer: CAShapeLayer!
	private var downLayer: CAShapeLayer!
	private var upLayer: CAShapeLayer!
	private var playLayer: CAShapeLayer!
	private var gradientLayer = CAGradientLayer()
	private var icons: [CALayer] {
		return [self.closeLayer, self.downLayer, self.upLayer, self.playLayer]
	}
	
	// MARK: - State
	private(set) var progress: CGFloat = 0
	private(set) var type: ProgressType = .indeterminate
	
	public var isAnimate: Bool {
		return self.type == .indeterminate && self.isHidden == false
	}
	var icon: Icon {
		get {
			if !self.closeLayer.isHidden {
				return .stop
			} else if !self.downLayer.isHidden {
				return .download
			} else if !self.upLayer.isHidden {
				return .upload
			} else if !self.playLayer.isHidden {
				return .play
			} else {
				return .none
			}
		}
		
		set {
			guard let layer = self.layer(for: newValue) else {
				self.icons.forEach { $0.isHidden = true }
				self.backgroundLayer.opacity = 0
				return
			}
			guard layer.isHidden == true else { return }
			self.backgroundLayer.opacity = 1
			self.icons.forEach { $0.isHidden = $0 != layer }
			self.set(progress: 0)
		}
	}
	
	override var frame: CGRect {
		didSet {
			self.backgroundLayer.frame = self.bounds
			self.circleLayer.frame = self.bounds
			self.gradientLayer.frame = self.bounds
		}
	}
	
	// MARK: - Constants
	
	let lineWidth: CGFloat = 2
	let indeterminateDuration: Double = 1.5
	let imageFraction: CGFloat = 0.4
	
	// MARK: - Initialization
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		self.setup()
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		self.setup()
	}
	
	func setup() {
		self.backgroundColor = .clear
		self.layer.backgroundColor = UIColor.clear.cgColor
		let delta = self.lineWidth/2
		
		self.backgroundLayer.path = UIBezierPath(ovalIn: self.bounds.insetBy(dx: delta, dy: delta)).cgPath
		self.backgroundLayer.fillColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.52).cgColor
		self.backgroundLayer.strokeColor = UIColor.white.cgColor
		self.backgroundLayer.lineWidth = self.lineWidth
		self.backgroundLayer.backgroundColor = UIColor.clear.cgColor
		self.layer.addSublayer(self.backgroundLayer)
		
		let center = CGPoint(x: self.bounds.size.width/2, y: self.bounds.size.height/2)
		self.circleLayer.path = UIBezierPath(arcCenter: center, radius: center.x - delta, startAngle: CGFloat.pi/2, endAngle: 5*CGFloat.pi/2, clockwise: true).cgPath
		self.circleLayer.strokeColor = UIColor.white.cgColor
		self.circleLayer.lineWidth = self.lineWidth
		self.circleLayer.lineCap = .square
		self.circleLayer.strokeStart = 0
		self.circleLayer.strokeEnd = 0
		self.circleLayer.backgroundColor = UIColor.clear.cgColor
		self.circleLayer.fillColor = UIColor.clear.cgColor
		
		let startColor = UIColor(red: 0.22, green: 0.55, blue: 0.9, alpha: 1).cgColor
		let endColor = UIColor(red: 0.4, green: 0.76, blue: 0.99, alpha: 1).cgColor
		self.gradientLayer.frame = self.bounds
		self.gradientLayer.colors = [startColor, endColor]
		self.gradientLayer.locations = [0, 1]
		self.gradientLayer.mask = self.circleLayer
		self.layer.addSublayer(self.gradientLayer)
		
		self.closeLayer = self.cross()
		self.layer.addSublayer(self.closeLayer)
		self.closeLayer.isHidden = true
		
		self.downLayer = self.download()
		self.layer.addSublayer(self.downLayer)
		self.downLayer.isHidden = true
		
		self.upLayer = self.upload()
		self.layer.addSublayer(self.upLayer)
		self.upLayer.isHidden = true
		
		self.playLayer = self.player()
		self.layer.addSublayer(self.playLayer)
		self.playLayer.isHidden = true
		
		self.icon = .none
	}
	
	func imageRect() -> CGRect {
		let x = self.bounds.size.width*(1 - self.imageFraction)/2
		let y = self.bounds.size.height*(1 - self.imageFraction)/2
		let w = self.bounds.size.width*self.imageFraction
		let h = self.bounds.size.height*self.imageFraction
		return CGRect(x: x, y: y, width: w, height: h)
	}
	
	// MARK: - Shapes
	
	func cross() -> CAShapeLayer {
		let layer = CAShapeLayer()
		var rect = self.imageRect()
		rect = rect.insetBy(dx: rect.width*0.1, dy: rect.height*0.1)
		layer.frame = rect
		
		let path = UIBezierPath()
		path.move(to: CGPoint(x: 0, y: 0))
		path.addLine(to: CGPoint(x: rect.width, y: rect.height))
		path.move(to: CGPoint(x: 0, y: rect.height))
		path.addLine(to: CGPoint(x: rect.width, y: 0))
		
		layer.lineWidth = self.lineWidth
		layer.strokeColor = UIColor.white.cgColor
		layer.path = path.cgPath
		return layer
	}
	
	func download() -> CAShapeLayer {
		let layer = CAShapeLayer()
		var rect = self.imageRect()
		let dh = rect.height*0.3
		let d = self.lineWidth*sqrt(2)/4
		rect = CGRect(x: rect.origin.x, y: rect.origin.y - dh/2, width: rect.width, height: rect.height + dh)
		layer.frame = rect
		
		let path = UIBezierPath()
		path.move(to: CGPoint(x: rect.width/2, y: 0))
		path.addLine(to: CGPoint(x: rect.width/2, y: rect.width))
		path.move(to: CGPoint(x: d, y: rect.width/2 + d))
		path.addLine(to: CGPoint(x: rect.width/2, y: rect.width))
		path.addLine(to: CGPoint(x: rect.width - d, y: rect.width/2 + d))
		path.move(to: CGPoint(x: 0, y: rect.height))
		path.addLine(to: CGPoint(x: rect.width, y: rect.height))
		
		layer.path = path.cgPath
		layer.strokeColor = UIColor.white.cgColor
		layer.fillColor = UIColor.clear.cgColor
		layer.lineWidth = self.lineWidth
		
		return layer
	}
	
	func upload() -> CAShapeLayer {
		let layer = CAShapeLayer()
		var rect = self.imageRect()
		let dh = rect.height*0.3
		let d = self.lineWidth*sqrt(2)/4
		rect = CGRect(x: rect.origin.x, y: rect.origin.y - dh/2, width: rect.width, height: rect.height + dh)
		layer.frame = rect
		
		let path = UIBezierPath()
		path.move(to: CGPoint(x: 0, y: rect.width/2 - d))
		path.addLine(to: CGPoint(x: rect.width/2, y: 0))
		path.addLine(to: CGPoint(x: rect.width - d, y: rect.width/2 - d))
		path.move(to: CGPoint(x: rect.width/2, y: 0))
		path.addLine(to: CGPoint(x: rect.width/2, y: rect.height))
		
		layer.path = path.cgPath
		layer.lineWidth = self.lineWidth
		layer.strokeColor = UIColor.white.cgColor
		layer.fillColor = UIColor.clear.cgColor
		
		return layer
	}
	
	func player() -> CAShapeLayer {
		let layer = CAShapeLayer()
		let rect = self.imageRect()
		layer.frame = rect
		
		let path = UIBezierPath()
		path.move(to: CGPoint(x: rect.width*0.25, y: 0))
		path.addLine(to: CGPoint(x: rect.width*0.95, y: rect.height/2))
		path.addLine(to: CGPoint(x: rect.width*0.25, y: rect.height))
		path.addLine(to: CGPoint(x: rect.width*0.25, y: 0))
		path.close()
		
		layer.path = path.cgPath
		layer.lineWidth = 0
		layer.fillColor = UIColor.white.cgColor
		
		return layer
	}
	
	func layer(for icon: Icon) -> CALayer? {
		switch icon {
		case .none:
			return nil
		case .stop:
			return self.closeLayer
		case .download:
			return self.downLayer
		case .upload:
			return self.upLayer
		case .play:
			return self.playLayer
		}
	}
	
	// MARK: - Animations
	
	func indeterminatedProgressAnimation() -> CAAnimation {
		let headAnimation = CABasicAnimation(keyPath: "strokeStart")
		headAnimation.beginTime = indeterminateDuration / 3
		headAnimation.fromValue = 0
		headAnimation.toValue = 1
		headAnimation.duration = indeterminateDuration / 1.5
		headAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
		
		let tailAnimation = CABasicAnimation(keyPath: "strokeEnd")
		tailAnimation.fromValue = 0
		tailAnimation.toValue = 1
		tailAnimation.duration = indeterminateDuration / 1.5
		tailAnimation.fillMode = .forwards
		tailAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
		
		let groupAnimation = CAAnimationGroup()
		groupAnimation.duration = indeterminateDuration
		groupAnimation.repeatCount = Float.infinity
		groupAnimation.animations = [headAnimation, tailAnimation]
		return groupAnimation
	}
	
	func rotationAnimation() -> CAAnimation {
		let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")
		rotationAnimation.fromValue = 0
		rotationAnimation.toValue = 2 * Double.pi
		rotationAnimation.duration = indeterminateDuration*2.2
		rotationAnimation.repeatCount = Float.infinity
		return rotationAnimation
	}
	
	func determinateProgressAnimation(_ progress: CGFloat) -> CAAnimation {
		let animation = CABasicAnimation(keyPath: "strokeEnd")
		animation.fromValue = self.circleLayer.strokeEnd
		animation.toValue = progress
		animation.duration = 0.2
		animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
		self.circleLayer.strokeEnd = progress
		return animation
	}
	
	// MARK: - Public API
	
	func startAnimating() {
		guard !self.isAnimate else { return }
		self.icon = .none
		self.isHidden = false
		self.type = .indeterminate
		self.circleLayer.removeAllAnimations()
		self.circleLayer.add(self.indeterminatedProgressAnimation(), forKey: "strokeLineAnimation")
		self.circleLayer.add(self.rotationAnimation(), forKey: "rotationAnimation")
	}
	
	func stopAnimating() {
		self.isHidden = true
		self.circleLayer.removeAllAnimations()
	}
	
	func set(progress: CGFloat) {
		self.isHidden = false
		self.type = .determinate
		self.progress = progress
		self.circleLayer.removeAllAnimations()
		
		if progress == 0 {
			self.circleLayer.strokeStart = 0
			self.circleLayer.strokeEnd = 0
		} else {
			self.circleLayer.add(self.determinateProgressAnimation(progress), forKey: "progressAnimation")
		}
	}
    
    func set(rotatedProgress: CGFloat) {
        self.isHidden = false
        self.type = .determinate
        self.progress = rotatedProgress
        //self.circleLayer.removeAllAnimations()
        
        if self.circleLayer.animation(forKey: "strokeLineAnimation") != nil {
            self.circleLayer.removeAnimation(forKey: "strokeLineAnimation")
        }
        if self.circleLayer.animation(forKey: "rotationAnimation") == nil {
            self.circleLayer.add(self.rotationAnimation(), forKey: "rotationAnimation")
        }
        
        if progress == 0 {
            self.circleLayer.strokeStart = 0
            self.circleLayer.strokeEnd = 0
        } else {
            self.circleLayer.add(self.determinateProgressAnimation(progress), forKey: "progressAnimation")
        }
    }
	
	// MARK: - Usage examples
	
	func loadPreview() {
		self.icon = .none
		self.startAnimating()
	}
	
	func showDownloadButton() {
		self.icon = .download
		self.set(progress: 0)
	}
	
	func showPlayButton() {
		self.icon = .play
		self.set(progress: 0)
	}
}
