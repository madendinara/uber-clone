//
//  LoginViewController.swift
//  uber-clone
//
//  Created by Динара Зиманова on 12/14/21.
//

import UIKit
import SnapKit

class LoginViewController: UIViewController {
    
    // MARK: - Properties
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir-Light", size: 36)
        label.textColor = UIColor.init(white: 1, alpha: 0.8)
        label.text = "UBER"
        return label
    }()
    private lazy var emailTextField: InputTextField = {
        let textField = InputTextField(placeholderText: "Email")
        return textField
    }()
    private lazy var passwordTextField: InputTextField = {
        let textField = InputTextField(placeholderText: "Password")
        return textField
    }()
    private lazy var emailIconImageView: UIImageView = {
        let imageView =  UIImageView()
        imageView.image = UIImage(named: "ic_mail_outline_white_2x")
        imageView.alpha = 0.8
        return imageView
    }()
    private lazy var passwordIconImageView: UIImageView = {
        let imageView =  UIImageView()
        imageView.image = UIImage(named: "ic_lock_outline_white_2x")
        imageView.alpha = 0.8
        return imageView
    }()
    private lazy var emailContainerView: UIView = {
        let view = UIView()
        
        let separator = UIView()
        separator.backgroundColor = .lightGray
        view.addSubview(separator)
        separator.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(0.5)
        }
        
        return view
    }()
    private lazy var passwordContainerView: UIView = {
        let view = UIView()
        
        let separator = UIView()
        separator.backgroundColor = .lightGray
        view.addSubview(separator)
        separator.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(0.5)
        }
        
        return view
    }()
    private lazy var inputsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [emailContainerView, passwordContainerView, loginButton])
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.spacing = 16
        return stackView
    }()
    private lazy var signUpButton: UIButton = {
        let button = UIButton(type: .system)
        
        let attributedString = NSMutableAttributedString.init(string: "Don't have an account? ", attributes: [.font: UIFont.systemFont(ofSize: 14), .foregroundColor: UIColor.lightGray])
        attributedString.append(NSAttributedString(string: "Sign Up", attributes: [.font: UIFont.boldSystemFont(ofSize: 14), .foregroundColor: UIColor.systemBlue]))
        
        button.setAttributedTitle(attributedString, for: .normal)
        return button
    }()
    private lazy var loginButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBlue
        button.setTitle("Log In", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.layer.cornerRadius = 5
        button.isEnabled = false
        return button
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: - Methods
    func configureView() {
        [titleLabel, inputsStackView, signUpButton].forEach { view.addSubview($0) }
        
        [emailIconImageView, emailTextField].forEach { emailContainerView.addSubview($0) }
        [passwordIconImageView, passwordTextField].forEach { passwordContainerView.addSubview($0) }
        
        view.backgroundColor = UIColor.init(red: 25/255, green: 25/255, blue: 25/255, alpha: 1)
        makeConstaints()
    }
    
    func makeConstaints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(12)
            make.centerX.equalToSuperview()
        }
        emailIconImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(8)
            make.size.equalTo(CGSize(width: 24, height: 24))
        }
        emailTextField.snp.makeConstraints { make in
            make.leading.equalTo(emailIconImageView.snp.trailing).offset(8)
            make.trailing.equalToSuperview()
            make.centerY.equalTo(emailIconImageView)
        }
        passwordIconImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(8)
            make.size.equalTo(CGSize(width: 24, height: 24))
        }
        passwordTextField.snp.makeConstraints { make in
            make.leading.equalTo(passwordIconImageView.snp.trailing).offset(8)
            make.trailing.equalToSuperview()
            make.centerY.equalTo(passwordIconImageView)
        }
        inputsStackView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(40)
            make.centerX.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(160)
        }
        signUpButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(12)
            make.centerX.equalToSuperview()
        }
    }
}