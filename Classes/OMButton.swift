import UIKit

enum OMButtonStyle {
    case primary
    case secondary
    case plain
    case ghostDark
    case readMore
}
//AL.

class OMButton: UIControl {
    private var gradientLayerCount = 0

    // MARK: Public contract
    var style: OMButtonStyle = .primary {
        didSet {
            // Resolve issue if primary set multiple times adds multiple gradient layers
            if style == oldValue {
                return
            }

            apply(style: style)
            layoutSubviews()
        }
    }

    override var isEnabled: Bool {
        didSet {
            switch isEnabled {
            case true:
                apply(style: style)
            case false:
                applyDisabledScheme()
            }
        }
    }

    var title: String? = nil {
        didSet {
            titleLabel.text = title
        }
    }

    //var titleColor: UIColor = .omWhite {
    var titleColor: UIColor = .white {
        didSet {
            titleLabel.textColor = titleColor
        }
    }

    var titleFont: UIFont? = nil {
        didSet {
            titleLabel.font = titleFont
        }
    }

    var titleAlignment: NSTextAlignment = .left {
        didSet {
            titleLabel.textAlignment = titleAlignment
        }
    }

    var iconImage: UIImage? = nil {
        didSet {
            icon.image = iconImage
        }
    }

    //var iconImageTint: UIColor = .omWhite {
    var iconImageTint: UIColor = .white {
        didSet {
            icon.tintColor = iconImageTint
        }
    }

    var borderColor: UIColor = .clear {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }

    // MARK: Internal Views
    private let titleLabel: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        //AL.
        //title.font = .buttonLabel12
        return title
    }()

    private let icon: UIImageView = {
        //AL.
        //let icon = UIImageView(image: .forwardArrow)
        let forwardArrow = UIImage(named: "disclosure")?.withRenderingMode(.alwaysTemplate)
        let icon = UIImageView(image: forwardArrow)
        //
        icon.contentMode = .scaleAspectFit
        icon.autoresizesSubviews = true
        //icon.tintColor = .omWhite
        icon.tintColor = .white
        icon.translatesAutoresizingMaskIntoConstraints = false
        return icon
    }()

    // MARK: Private methods
    private func applyPrimaryScheme() {
        //titleLabel.textColor = .omWhite
        titleLabel.textColor = .white
        //setGradientBackground(colors: [.omHeritageGreen, .omFutureGreen])
        gradientLayerCount += 1
        //iconImageTint = .omWhite
        iconImageTint = .white
        borderColor = .clear
    }

    private func applySecondaryScheme() {
        removeGradientLayers()
        //titleLabel.textColor = .omWhite
        titleLabel.textColor = .white
        //borderColor = .omWhite
        borderColor = .white
        backgroundColor = .clear
        //iconImageTint = .omWhite
        iconImageTint = .white
    }

    private func applyPlainScheme() {
        removeGradientLayers()
        //titleLabel.textColor = .wealthOnyx
        titleLabel.textColor = .gray
        //iconImageTint = .wealthOnyx
        iconImageTint = .gray
        //backgroundColor = .omWhite
        backgroundColor = .white
        borderColor = .clear
    }

    private func applyDarkGhostScheme() {
        removeGradientLayers()
        //titleLabel.textColor = .wealthOnyx
        titleLabel.textColor = .gray
        //borderColor = .wealthOnyx
        borderColor = .gray
        backgroundColor = .clear
        //iconImageTint = .wealthOnyx
        iconImageTint = .gray
    }

    private func applyReadMoreScheme() {
        removeGradientLayers()
        //title = WealthStrings.Buttons.readMore
        title = "Read More (default string)"
        //titleFont = UIFont(weight: .medium, 10)
        //titleLabel.textColor = .omHeritageGreen
        titleLabel.textColor = .green
        //iconImageTint = .omHeritageGreen
        iconImageTint = .blue
        backgroundColor = .clear
        borderColor = .clear
    }

    private func apply(style: OMButtonStyle) {
        switch style {
        case .primary:
            applyPrimaryScheme()
        case .secondary:
            applySecondaryScheme()
        case .plain:
            applyPlainScheme()
        case .ghostDark:
            applyDarkGhostScheme()
        case .readMore:
            applyReadMoreScheme()
        }
    }

    private func applyDisabledScheme() {
        removeGradientLayers()
        //titleLabel.textColor = .wealthCoolGrey
        titleLabel.textColor = .gray
        //borderColor = .wealthCoolGrey
        borderColor = .gray
        backgroundColor = .clear
        //iconImageTint = .wealthCoolGrey
        iconImageTint = .gray
    }

    private func removeGradientLayers() {
        for _ in 0..<gradientLayerCount {
            layer.sublayers?.remove(at: 0)
        }
        gradientLayerCount = 0
    }

    // MARK: Initialization
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUpView()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
    }

    convenience init(_ style: OMButtonStyle, _ title: String? = nil) {
        defer {
            self.style = style
            self.title = title
        }
        self.init()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        setUpView()
    }

    private func setUpView() {
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 20
        layer.masksToBounds = true
        layer.borderWidth = 1
        isUserInteractionEnabled = true

        if self.isEnabled {
            switch style {
            case .primary:
                applyPrimaryScheme()
            case .secondary:
                applySecondaryScheme()
            case .plain:
                applyPlainScheme()
            case .ghostDark:
                applyDarkGhostScheme()
            case .readMore:
                applyReadMoreScheme()
            }
        } else {
            applyDisabledScheme()
        }

        addSubview(titleLabel)
        addSubview(icon)

        let widthConstraint = widthAnchor.constraint(equalToConstant: 218)
        widthConstraint.priority = .defaultLow
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 40),
            widthConstraint,

            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor),

            icon.leadingAnchor.constraint(greaterThanOrEqualTo: titleLabel.trailingAnchor, constant: 20),
            icon.centerYAnchor.constraint(equalTo: centerYAnchor),
            icon.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24)
        ])
    }
}
