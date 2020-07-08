import Foundation
import UIKit

extension UIFont {

    enum TypefaceStyle: String {
        case text = "Montserrat"
        case numbers = "Palanquin"
    }

    enum FontWeight: String {
        case regular = "Regular"
        case medium = "Medium"
        case bold = "Bold"
        case light = "Light"
        case italic = "Italic"
        case mediumItalic = "MediumItalic"
        case semiBold = "SemiBold"
        case lightItalic = "LightItalic"
        case thin = "Thin"
    }

    convenience init?(_ style: TypefaceStyle = .text, weight: FontWeight, _ size: CGFloat) {
        self.init(name: "\(style.rawValue)-\(weight.rawValue)", size: size)
    }

    func withAttributes(kern: CGFloat = 0, lineHeight: CGFloat = 0, colour: UIColor? = nil) -> TextAttributes {
        TextAttributes(self, kern: kern, lineHeight: lineHeight, colour: colour)
    }

    // MARK: Named fonts

    static let headingH1 = UIFont(weight: .medium, 22)
    static let headingH5 = UIFont(weight: .regular, 16)

    static let bodyP = UIFont(weight: .regular, 14)
    static let bodyP1 = UIFont(weight: .semiBold, 14)
    static let bodyP2 = UIFont(weight: .regular, 12)
    static let bodyP3 = UIFont(weight: .semiBold, 12)

    static let buttonLabel12 = UIFont(weight: .medium, 12)

    static let cardCaption = UIFont(weight: .light, 10)

    static let alertBody = UIFont(weight: .regular, 10)
    static let alertEmphasis = UIFont(weight: .semiBold, 10)
    static let alertCallToAction = UIFont(weight: .bold, 10)

    static let tabDefault = UIFont(weight: .regular, 10)
    static let tabSelected = UIFont(weight: .semiBold, 10)

    // The following fonts should not be used and should be removed when possible
    static let wealthFontHeader = UIFont(weight: .medium, 16)
    static let wealthFontLargeBody = UIFont(weight: .light, 20)

    static let cardTitle = UIFont(weight: .bold, 10)
} // MARK: -

typealias TextAttributes = [NSAttributedString.Key: Any]
extension TextAttributes where Key == NSAttributedString.Key, Value == Any {

    // MARK: Named styles (from styleguide)
    static let headingH1 = TextAttributes(UIFont(weight: .medium, 22)!, kern: 1, lineHeight: 30)
    static let headingH2 = UIFont(weight: .regular, 22)?.withAttributes(kern: 1, lineHeight: 30)
    static let headingH3 = UIFont(weight: .semiBold, 22)?.withAttributes(kern: 1, lineHeight: 30)
    static let headingH4 = TextAttributes(UIFont(weight: .semiBold, 16)!, lineHeight: 22)
    static let headingH5 = TextAttributes(UIFont(weight: .regular, 16)!, kern: 1, lineHeight: 15)
    static let headingH6 = TextAttributes(UIFont(weight: .medium, 14)!, kern: 1, lineHeight: 15)
    static let headingH8 = UIFont(.numbers, weight: .thin, 22)?.withAttributes(lineHeight: 17)
    static let headingH9 = TextAttributes(UIFont(weight: .regular, 24)!, lineHeight: 30)
    static let headingH10 = TextAttributes(UIFont(weight: .semiBold, 24)!, lineHeight: 30)

    static let snapScrollHeader = TextAttributes(UIFont(weight: .medium, 16)!, kern: 1, lineHeight: 15)

    static let portfolioOverviewHeaderMainValue = UIFont(.numbers, weight: .thin, 45)?.withAttributes(lineHeight: 60)
    static let portfolioOverviewHeaderMainDescription = TextAttributes(UIFont(weight: .regular, 15)!)
    static let portfolioOverviewHeaderSecondaryValue = UIFont(.numbers, weight: .thin, 15)?.withAttributes()
    static let portfolioOverviewHeaderSecondaryDescription = TextAttributes(UIFont(weight: .regular, 11)!)

    static let cardTitle: TextAttributes = {
        var cardTitle = TextAttributes(UIFont(weight: .medium, 11)!, kern: 1, lineHeight: 10).setColour(to: .omWhite)
        guard let style = cardTitle[.paragraphStyle] as? NSMutableParagraphStyle else { return cardTitle }
        style.lineBreakMode = .byTruncatingTail
        cardTitle[.paragraphStyle] = style
        return cardTitle
    }()

    static let cardNumber = TextAttributes(UIFont(.numbers, weight: .regular, 13)!, lineHeight: 17)
    static let cardValueDescription = TextAttributes(UIFont(.numbers, weight: .regular, 11)!)
    static let cardDefaultText = TextAttributes(UIFont(weight: .regular, 10)!)
    static let cardEmphasisText = TextAttributes(UIFont(weight: .semiBold, 10)!)
    static let cardTimeAndDate = UIFont(weight: .medium, 10)?.withAttributes(kern: 2, lineHeight: 16)

    static let splashHeader = TextAttributes(UIFont(weight: .light, 38)!, kern: -1, lineHeight: 42)
    static let splashHeaderEmphasis = TextAttributes(UIFont(weight: .medium, 38)!, kern: -1, lineHeight: 42)
    static let splashWealthHeader = TextAttributes(UIFont(weight: .bold, 14)!)

    static let bodyP0 = UIFont.bodyP?.withAttributes(lineHeight: 20)
    static let bodyP1 = UIFont.bodyP1?.withAttributes(lineHeight: 20)
    static let bodyP2 = UIFont.bodyP2?.withAttributes(lineHeight: 18)
    static let bodyP3 = UIFont.bodyP3?.withAttributes(lineHeight: 18)

    static let formSelected = TextAttributes(UIFont(weight: .regular, 14)!, lineHeight: 19)
    static let formOptionList = TextAttributes(UIFont(weight: .regular, 12)!, lineHeight: 19)

    static let overline = TextAttributes(UIFont(weight: .medium, 11)!, kern: 2, lineHeight: 16)

    static let tabDefault = UIFont.tabDefault?.withAttributes(lineHeight: 9, colour: .wealthPeriwinkle)
    static let tabSelected = UIFont.tabSelected?.withAttributes(lineHeight: 9, colour: .white)

    static let percentageStyle = TextAttributes.cardTitle.centred

    // MARK: Initializers for new styles
    init(_ font: UIFont, kern: CGFloat = 0, lineHeight: CGFloat = 0, colour: UIColor? = nil) {
        self = [.font: font]
        if kern > 0 {
            self[.kern] = kern
        }
        if lineHeight > 0 {
            self[.paragraphStyle] = Self.lineHeight(lineHeight)
        }
        if let colour = colour {
            self[.foregroundColor] = colour
        }
    }

    var underlined: TextAttributes {
        var underlinedAttributes = self
        underlinedAttributes[.underlineStyle] = NSUnderlineStyle.styleSingle.rawValue
        return underlinedAttributes
    }

    var centred: TextAttributes {
        guard let paragraphStyle = self[.paragraphStyle] as? NSMutableParagraphStyle else { return self }
        paragraphStyle.alignment = .center
        var attributes = self
        attributes[.paragraphStyle] = paragraphStyle
        return attributes
    }

    // MARK: Helpers
    private static var lineHeightDictionary: [CGFloat: NSParagraphStyle] = [:]
    private static let lineHeight: (CGFloat) -> NSParagraphStyle = {
        if let style = lineHeightDictionary[$0] { return style }
        let style = NSMutableParagraphStyle()
        style.minimumLineHeight = $0
        lineHeightDictionary[$0] = style as NSParagraphStyle
        return style
    }

    func withUnderline() -> TextAttributes {
        var attributes = self
        attributes[.underlineStyle] = NSUnderlineStyle.styleSingle.rawValue
        return attributes
    }

    func setColour(to colour: UIColor) -> TextAttributes {
        var attributes = self
        attributes[.foregroundColor] = colour
        return attributes
    }
}

extension TextAttributes {
    static let snapshotPrimaryValueStyle = UIFont(.numbers, weight: .thin, 36)?.withAttributes(lineHeight: 17)
    static let snapshotSecondaryValueStyle = UIFont(.numbers, weight: .thin, 18)?.withAttributes(lineHeight: 17)
}
