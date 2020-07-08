//
//  OMTextField.swift
//  Pods-protopod_Example
//
//  Created by Altamish Mahomed on 2020/07/08.
//

import Foundation

import UIKit
import MaterialComponents.MaterialTextFields

protocol OMTextFieldDelegate: class {
    func OMTextFieldDidDeleteBackwards(textField: OMTextField)
}

enum OMTextFieldStyle {
    case dark
    case light
}

class OMTextField: MDCTextField {

    weak var omDelegate: OMTextFieldDelegate?

    var style: OMTextFieldStyle = .dark {
        didSet {
            setUpView()
        }
    }

    // MARK: UI Components
    private var inputController: OMTextInputController!

    // MARK: Initialization
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUpView()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
    }

    func set(state: MDCControllerState) {
        inputController.set(state: state)
    }

    // MARK: Set Up View
    private func setUpView() {
        clearButtonMode = .never
        translatesAutoresizingMaskIntoConstraints = false
        inputController = createTextInputController()
        setTextColorAccordingToStyle()
        inputController.set(state: .normal)
        addTarget(self, action: #selector(setActive), for: .editingDidBegin)
    }

    func createTextInputController() -> OMTextInputController {
        switch style {
        case .dark:
            return OMDarkTextInputController(textInput: self)
        case .light:
            return OMLightTextInputController(textInput: self)
        }
    }

    func setTextColorAccordingToStyle() {
        switch style {
        case .dark:
            textColor = .omWhite
        case .light:
            textColor = .omOnyx
        }
    }

    @objc private func setActive() {
        set(state: .active)
    }

    func setInputFont(font: UIFont) {
        inputController.textInputFont = font
    }

    override func deleteBackward() {
        super.deleteBackward()
        omDelegate?.OMTextFieldDidDeleteBackwards(textField: self)
    }
}

enum MDCControllerState {
    case normal
    case error(text: String)
    case active
}

class OMTextInputController: MDCTextInputControllerUnderline {
    override init() {
        // Do not delete - This really is necessary ='(
        // This is due to weird Objective-C compatibility issues
        super.init()
    }

    required init(textInput input: (UIView & MDCTextInput)?) {
        super.init(textInput: input)
        inlinePlaceholderFont = .bodyP
        textInputFont = .bodyP

        // Normal State
        normalColor = .wealthSlate
        floatingPlaceholderNormalColor = .wealthSlate
        inlinePlaceholderColor = .wealthCoolGrey

        // Active State
        floatingPlaceholderActiveColor = .wealthCoolGrey
        activeColor = .wealthCobalt

        // Error State
        errorColor = .omAlert
    }

    func set(state: MDCControllerState) {
        switch state {
        case .normal:
            normalColor = .wealthSlate
            floatingPlaceholderNormalColor = .wealthSlate
            setErrorText(nil, errorAccessibilityValue: nil)
        case .error(let errorText):
            setErrorText(errorText, errorAccessibilityValue: errorText)
        case .active:
            setErrorText(nil, errorAccessibilityValue: nil)
        }
    }
}

class OMDarkTextInputController: OMTextInputController {
    override init() {
        // Do not delete - This really is necessary ='(
        // This is due to weird Objective-C compatibility issues
        super.init()
    }

    required init(textInput input: (UIView & MDCTextInput)?) {
        super.init(textInput: input)

        // Normal State
        inlinePlaceholderColor = .wealthCoolGrey
    }

    override func set(state: MDCControllerState) {
        super.set(state: state)
        inlinePlaceholderColor = .wealthCoolGrey
    }
}

class OMLightTextInputController: OMTextInputController {
    override init() {
        // Do not delete - This really is necessary ='(
        // This is due to weird Objective-C compatibility issues
        super.init()
    }

    required init(textInput input: (UIView & MDCTextInput)?) {
        super.init(textInput: input)

        // Normal State
        inlinePlaceholderColor = .wealthCoolGrey
    }

    override func set(state: MDCControllerState) {
        super.set(state: state)
        inlinePlaceholderColor = .wealthCoolGrey
    }
}

//AL.
//TODO
//extension Reactive where Base: OMTextField {
//    var state: Binder<MDCControllerState> {
//        Binder(self.base) { (textField: OMTextField, state: MDCControllerState) in
//            textField.set(state: state)
//        }
//    }
//
//    var placeholder: Binder<String?> {
//        Binder(self.base) { (textField: OMTextField, placeholder: String?) in
//            textField.placeholder = placeholder
//        }
//    }
//
//    var validationState: Binder<ValidationState> {
//        Binder(self.base) { (textField: OMTextField, validationState: ValidationState) in
//            let state: MDCControllerState
//
//            switch validationState {
//            case .valid:
//                state = .normal
//            case .invalid(let message):
//                state = .error(text: message)
//            }
//
//            textField.set(state: state)
//        }
//    }
//}
