//
//  Themable.swift
//  protopod_Example
//
//  Created by Altamish Mahomed on 2020/08/14.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation
import UIKit

enum ComponentState {
    case normal, active, error, disabled
}

protocol ThemeDelegate: class {
    func getBackgroundColour(_ component: ThemableComponent, state: ComponentState) -> UIColor
}

protocol ThemableComponent: UIView {
    var themeDelegate: ThemeDelegate? { get set }
    var componentState: ComponentState { get }
    var backgroundColour: UIColor? { get }
    init(delegate: ThemeDelegate)
    func updateComponent(forState state: ComponentState)
}

extension ThemableComponent {

    var componentState: ComponentState { .normal }

    var backgroundColour: UIColor? {
        themeDelegate?.getBackgroundColour(self, state: componentState)
    }

    init(delegate: ThemeDelegate) {
        self.init()
        self.themeDelegate = delegate
        self.updateComponent(forState: componentState)

        //defer { print("\(type(of: self).description()) init. delegate = \(themeDelegate.debugDescription)") }
    }
}
