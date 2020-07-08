//
//  UIColorExtensions.swift
//  My Old Mutual
//
//  Created by Dewald de Jager on 2019/04/19.
//  Copyright © 2019 Old Mutual. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")

        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }

    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }

    class var textPrimary: UIColor {
        return UIColor(rgb: 0x555555)
    }

    @nonobjc class var omLightPeriwinkle: UIColor {
        return UIColor(red: 220.0 / 255.0, green: 221.0 / 255.0, blue: 222.0 / 255.0, alpha: 1.0)
    }

    // Old Mutual Corporate Identity - Named Colours

    @nonobjc class var omHeritageGreen: UIColor {
        return UIColor(red: 0.0, green: 150.0 / 255.0, blue: 119.0 / 255.0, alpha: 1.0)
    }

    @nonobjc class var omFreshGreen: UIColor {
        return UIColor(red: 80.0 / 255.0, green: 184.0 / 255.0, blue: 72.0 / 255.0, alpha: 1.0)
    }

    @nonobjc class var omFutureGreen: UIColor {
        return UIColor(red: 141.0 / 255.0, green: 198.0 / 255.0, blue: 63.0 / 255.0, alpha: 1.0)
    }

    @nonobjc class var omOnyx: UIColor {
        return UIColor(white: 40.0 / 255.0, alpha: 1.0)
    }

    @nonobjc class var omOnyx65: UIColor {
        return UIColor(white: 183.0 / 255.0, alpha: 1.0)
    }

    @nonobjc class var omOnyx40: UIColor {
        return UIColor(white: 216.0 / 255.0, alpha: 1.0)
    }

    @nonobjc class var omSky: UIColor {
        return UIColor(red: 0.0, green: 192.0 / 255.0, blue: 232.0 / 255.0, alpha: 1.0)
    }

    @nonobjc class var omSun: UIColor {
        return UIColor(red: 1.0, green: 242.0 / 255.0, blue: 0.0, alpha: 1.0)
    }

    @nonobjc class var omNaartjie: UIColor {
        return UIColor(red: 243.0 / 255.0, green: 112.0 / 255.0, blue: 34.0 / 255.0, alpha: 1.0)
    }

    @nonobjc class var omCerise: UIColor {
        return UIColor(red: 237.0 / 255.0, green: 0.0, blue: 128.0 / 255.0, alpha: 1.0)
    }

    @nonobjc class var omSkySun: UIColor {
        return UIColor(red: 129.0 / 255.0, green: 235.0 / 255.0, blue: 94.0 / 255.0, alpha: 1.0)
    }

    @nonobjc class var omCeriseSky: UIColor {
        return UIColor(red: 71.0 / 255.0, green: 104.0 / 255.0, blue: 234.0 / 255.0, alpha: 1.0)
    }

    @nonobjc class var omNaartjieSun: UIColor {
        return UIColor(red: 249.0 / 255.0, green: 177.0 / 255.0, blue: 15.0 / 255.0, alpha: 1.0)
    }

    @nonobjc class var omCeriseSun: UIColor {
        return UIColor(red: 1.0, green: 119.0 / 255.0, blue: 0.0, alpha: 1.0)
    }

    @nonobjc class var omNaartjieCerise: UIColor {
        return UIColor(red: 1.0, green: 59.0 / 255.0, blue: 82.0 / 255.0, alpha: 1.0)
    }

    @nonobjc class var omDark: UIColor {
        return UIColor(red: 37.0 / 255.0, green: 33.0 / 255.0, blue: 51.0 / 255.0, alpha: 1.0)
    }

    @nonobjc class var omDarkLine: UIColor {
        return UIColor(red: 48.0 / 255.0, green: 43.0 / 255.0, blue: 64.0 / 255.0, alpha: 1.0)
    }

    @nonobjc class var omBackgroundDark: UIColor {
        return UIColor(red: 24.0 / 255.0, green: 21.0 / 255.0, blue: 38.0 / 255.0, alpha: 1.0)
    }

    @nonobjc class var omCardBGDark: UIColor {
        return UIColor(red: 43.0 / 255.0, green: 38.0 / 255.0, blue: 60.0 / 255.0, alpha: 1.0)
    }

    @nonobjc class var omLightGrey: UIColor {
        return UIColor(white: 239.0 / 255.0, alpha: 1.0)
    }

    @nonobjc class var omWhite: UIColor {
        return UIColor(white: 1.0, alpha: 1.0)
    }

    @nonobjc class var omAlert: UIColor {
        return UIColor(red: 232.0 / 255.0, green: 59.0 / 255.0, blue: 12.0 / 255.0, alpha: 1.0)
    }

    @nonobjc class var omDarkPastelGreen: UIColor {
        return UIColor(red: 96.0 / 255.0, green: 184.0 / 255.0, blue: 72.0 / 255.0, alpha: 1.0)
    }
}
