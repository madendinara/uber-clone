//
//  AuthButton.swift
//  uber-clone
//
//  Created by Динара Зиманова on 12/15/21.
//

import UIKit

class AuthButton: UIButton {
    
    // MARK: - Properties
    var buttonTitle: String
    
    // MARK: - Init
    init(buttonTitle: String) {
        self.buttonTitle = buttonTitle
        super.init(frame: .zero)
        configureButton(self.buttonTitle)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    func configureButton(_ buttonTitle: String) {
        backgroundColor = .mainBlue
        setTitle(buttonTitle, for: .normal)
        setTitleColor(UIColor.init(white: 1, alpha: 0.5), for: .normal)
        titleLabel?.font = UIFont.systemFont(ofSize: 14)
        layer.cornerRadius = 5
        isEnabled = false
        heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
}
