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

public class OMTextField: MDCTextField {

    weak var omDelegate: OMTextFieldDelegate?

    var themecolor: UIColor = .white {
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

    public func set(state: MDCControllerState) {
        inputController.set(state: state)
    }

    // MARK: Set Up View
    private func setUpView() {
        clearButtonMode = .never
        translatesAutoresizingMaskIntoConstraints = false
        inputController = createTextInputController()
        textColor = themecolor
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

    override public func deleteBackward() {
        super.deleteBackward()
        omDelegate?.OMTextFieldDidDeleteBackwards(textField: self)
    }

    public var colorNormal = UIColor.gray {
        didSet {
            inputController.colorNormal = self.colorNormal
        }
    }

    public var colorLight = UIColor.lightGray {
        didSet {
            inputController.colorLight = self.colorLight
        }
    }

    public var colorActive = UIColor.green {
        didSet {
            inputController.colorActive = self.colorActive
        }
    }

    public var colorError = UIColor.red {
        didSet {
            inputController.colorError = self.colorError
        }
    }

    public func setColors(normal: UIColor, light: UIColor, active: UIColor, error: UIColor) {
        inputController.colorNormal = normal
        inputController.colorLight = light
        inputController.colorActive = active
        inputController.colorError = error
    }
}

public enum MDCControllerState {
    case normal
    case error(text: String)
    case active
}

class OMTextInputControllerBase: MDCTextInputControllerUnderline {
    var inputFont = UIFont(name: "Helvetica", size: 14)

    var colorNormal = UIColor.gray {
        didSet {
            setNormalColor()
        }
    }
    private func setNormalColor() {
        normalColor = colorNormal
        floatingPlaceholderNormalColor = colorNormal
    }

    var colorLight = UIColor.lightGray {
        didSet {
            setLightColor()
        }
    }
    private func setLightColor() {
        inlinePlaceholderColor = colorLight
        floatingPlaceholderActiveColor = colorLight
    }

    var colorActive = UIColor.green {
        didSet {
            setActiveColor()
        }
    }
    private func setActiveColor() {
        activeColor = colorActive
    }

    var colorError = UIColor.red {
        didSet {
            setErrorColor()
        }
    }
    private func setErrorColor() {
        errorColor = colorError
    }

    override init() {
        // Do not delete - This really is necessary ='(
        // This is due to weird Objective-C compatibility issues
        super.init()
    }

    required init(textInput input: (UIView & MDCTextInput)?) {
        super.init(textInput: input)
        inlinePlaceholderFont = inputFont
        textInputFont = inputFont

        setNormalColor()
        setLightColor()
        setActiveColor()
        setErrorColor()
    }

    func set(state: MDCControllerState) {
        switch state {
        case .normal:
            setNormalColor()
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
        inlinePlaceholderColor = colorLight
    }

    override func set(state: MDCControllerState) {
        super.set(state: state)
        inlinePlaceholderColor = colorLight
    }
}

