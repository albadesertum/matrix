
import UIKit

class HandmadeSlider: UIControl {
    
    let lineView = UIView()
    
    let thumbImageView = UIImageView()
    
    let min: CGFloat = 0.0
    let max: CGFloat = 1.0
    
    private(set) var value: CGFloat = 0.0 {
        didSet {
            layoutSubviews()
        }
    }
    
    var thickness: CGFloat = 1.0 {
        didSet {
            layoutSubviews()
        }
    }
    
    var thumbImage: UIImage {
        get {
            return thumbImageView.image ?? UIImage()
        }
        set(image) {
            thumbImageView.image = image
            layoutSubviews()
        }
    }
    
    private(set) var isDrag = false
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    // MARK: - Override
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let margin: CGFloat = 8.0
        let imageSize = thumbImage.size
        let thumbSize = CGSize(width: 2.0 * margin + imageSize.width, height: 2.0 * margin + imageSize.height)
        let lineX = margin + 0.5 * imageSize.width
        let thumbX = value * (frame.width - thumbSize.width)
        lineView.frame = CGRect(x: lineX, y: 0.5 * (frame.height - thickness), width: frame.width - 2.0 * lineX, height: thickness)
        thumbImageView.frame = CGRect(x: thumbX, y: 0.5 * (frame.height - thumbSize.height), width: thumbSize.width, height: thumbSize.height)
    }
    
    // MARK: - Private
    
    private func setup() {
        backgroundColor = .clear
        lineView.backgroundColor = .white
        lineView.isUserInteractionEnabled = true
        thumbImageView.contentMode = .center
        thumbImageView.isUserInteractionEnabled = true
        addSubview(lineView)
        addSubview(thumbImageView)
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapGestureRecognizerAction(_:)))
        let longPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(longPressGestureRecognizerAction(_:)))
        longPressGestureRecognizer.minimumPressDuration = 0.0
        addGestureRecognizer(tapGestureRecognizer)
        thumbImageView.addGestureRecognizer(longPressGestureRecognizer)
        thumbImage = UIImage(named: "handmade_slider")!
    }
    
    private func applyThumbPosition(_ x: CGFloat) {
        if 0.0 <= x && x <= frame.width {
            value = x / frame.width
            sendActions(for: .valueChanged)
        }
    }
    
    // MARK: - Public
    
    public func setValue(_ value: CGFloat, animated: Bool = true) {
        if min <= value && value <= max {
            if animated {
                UIView.animate(withDuration: 0.8) {
                    self.value = value
                }
            } else {
                self.value = value
            }
        }
    }
    
    // MARK: - objc
    
    @objc private func tapGestureRecognizerAction(_ gestureRecognizer: UITapGestureRecognizer) {
        applyThumbPosition(gestureRecognizer.location(in: self).x)
    }
    
    @objc private func longPressGestureRecognizerAction(_ gestureRecognizer: UILongPressGestureRecognizer) {
        switch gestureRecognizer.state {
        case .changed:
            isDrag = true
            applyThumbPosition(gestureRecognizer.location(in: self).x)
            break
        default:
            isDrag = false
            break
        }
    }
}
