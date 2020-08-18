//
//  Styles.swift
//  protopod_Example
//
//  Created by Altamish Mahomed on 2020/08/14.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation
import UIKit

class WealthThemeDelegate: ThemeDelegate {
    func getBackgroundColour(_ component: ThemableComponent, state: ComponentState) -> UIColor {
        switch state {
        case .normal:
            return .blue
        case .active:
            return .blue
        case .disabled:
            return .darkGray
        case .error:
            return .gray
        }
    }
}

class MOMThemeDelegate: ThemeDelegate {
    func getBackgroundColour(_ component: ThemableComponent, state: ComponentState) -> UIColor {
        switch state {
        case .normal:
            return .green
        case .active:
            return .blue
        case .disabled:
            return .darkGray
        case .error:
            return .red
        }
    }
}
