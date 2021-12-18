//
//  InputTextField.swift
//  uber-clone
//
//  Created by Динара Зиманова on 12/14/21.
//

import UIKit

class AuthInputTextField: UITextField {
    
    // MARK: - Properties
    var placeholderText: String
    var isSecure: Bool
    
    // MARK: - Init
    init(placeholderText: String, isSecure: Bool) {
        self.placeholderText = placeholderText
        self.isSecure = isSecure
        super.init(frame: .zero)
        self.configureTextField(self.placeholderText, isSecure: self.isSecure)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    func configureTextField(_ placeholderText: String, isSecure: Bool) {
        isSecureTextEntry = isSecure
        borderStyle = .none
        font = UIFont.systemFont(ofSize: 16)
        textColor = .white
        keyboardAppearance = .dark
        attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
    }
}
