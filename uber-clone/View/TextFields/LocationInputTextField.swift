//
//  LocationInputTextField.swift
//  uber-clone
//
//  Created by Динара Зиманова on 12/18/21.
//

import UIKit

class LocationInputTextField: UITextField {
    
    // MARK: - Properties
    var placeholderText: String
    var isEnable: Bool
    var backColor: UIColor?
    
    // MARK: - Init
    init(placeholderText: String, isEnable: Bool, backColor: UIColor?) {
        self.placeholderText = placeholderText
        self.isEnable = isEnable
        self.backColor = backColor
        super.init(frame: .zero)
        self.configureTextField(self.placeholderText, isEnable: self.isEnable, backColor: self.backColor ?? .systemGray6)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    func configureTextField(_ placeholderText: String, isEnable: Bool, backColor: UIColor) {
        placeholder = placeholderText
        isEnabled = isEnable
        backgroundColor = backColor
        font = UIFont.systemFont(ofSize: 14)
        
        let paddingView = UIView()
        paddingView.frame.size = CGSize(width: 8, height: 30)
        leftView = paddingView
        leftViewMode = .always
    }
}
