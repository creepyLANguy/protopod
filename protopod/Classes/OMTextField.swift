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

class OMTextField: MDCTextField {

    weak var omDelegate: OMTextFieldDelegate?

    var themeColour: UIColor = .white {
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
        textColor = themeColour
        inputController.set(state: .normal)
        addTarget(self, action: #selector(setActive), for: .editingDidBegin)
    }

    func createTextInputController() -> OMTextInputController {
        return OMTextInputController(textInput: self)
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

class OMTextInputControllerBase: MDCTextInputControllerUnderline {
    var inputFont = UIFont(name: "Helvetica", size: 14)
    var colourNormal = UIColor.gray//(red: 88, green: 89, blue: 91)
    var colourLight = UIColor.lightGray//(red: 167, green: 169, blue: 172)
    var colourActive = UIColor.green
    var colourAlert = UIColor.red

    override init() {
        // Do not delete - This really is necessary ='(
        // This is due to weird Objective-C compatibility issues
        super.init()
    }

    required init(textInput input: (UIView & MDCTextInput)?) {
        super.init(textInput: input)
        inlinePlaceholderFont = inputFont
        textInputFont = inputFont

        // Normal State
        normalColor = colourNormal
        floatingPlaceholderNormalColor = colourNormal
        inlinePlaceholderColor = colourLight

        // Active State
        floatingPlaceholderActiveColor = colourLight
        activeColor = colourActive

        // Error State
        errorColor = colourAlert
    }

    func set(state: MDCControllerState) {
        switch state {
        case .normal:
            normalColor = colourNormal
            floatingPlaceholderNormalColor = colourNormal
            setErrorText(nil, errorAccessibilityValue: nil)
        case .error(let errorText):
            setErrorText(errorText, errorAccessibilityValue: errorText)
        case .active:
            setErrorText(nil, errorAccessibilityValue: nil)
        }
    }
}

class OMTextInputController: OMTextInputControllerBase {
    override init() {
        // Do not delete - This really is necessary ='(
        // This is due to weird Objective-C compatibility issues
        super.init()
    }

    required init(textInput input: (UIView & MDCTextInput)?) {
        super.init(textInput: input)

        // Normal State
        inlinePlaceholderColor = colourLight
    }

    override func set(state: MDCControllerState) {
        super.set(state: state)
        inlinePlaceholderColor = colourLight
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
