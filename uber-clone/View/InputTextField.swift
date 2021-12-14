//
//  InputTextField.swift
//  uber-clone
//
//  Created by Динара Зиманова on 12/14/21.
//

import UIKit

class InputTextField: UITextField {
    
    // MARK: - Properties
    var placeholderText: String
    
    // MARK: - Init
    init(placeholderText: String) {
        self.placeholderText = placeholderText
        super.init(frame: .zero)
        self.configureTextField(self.placeholderText)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    func configureTextField(_ placeholderText: String) {
        borderStyle = .none
        font = UIFont.systemFont(ofSize: 16)
        textColor = .white
        keyboardAppearance = .dark
        attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
    }
}
