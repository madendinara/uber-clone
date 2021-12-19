//
//  LoginController.swift
//  uber-clone
//
//  Created by Динара Зиманова on 12/14/21.
//

import UIKit
import SnapKit
import Firebase

class LoginController: UIViewController {
    
    // MARK: - Properties
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir-Light", size: 36)
        label.textColor = UIColor.init(white: 1, alpha: 0.8)
        label.text = "UBER"
        return label
    }()
    private lazy var emailTextField = AuthInputTextField(placeholderText: "Email", isSecure: false)
    private lazy var passwordTextField = AuthInputTextField(placeholderText: "Password", isSecure: true)
    private lazy var emailContainerView: InputView = {
        let view = InputView()
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return view
    }()
    private lazy var passwordContainerView: InputView = {
        let view = InputView()
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return view
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
        attributedString.append(NSAttributedString(string: "Sign Up", attributes: [.font: UIFont.boldSystemFont(ofSize: 14), .foregroundColor: UIColor.mainBlue]))
        
        button.addTarget(self, action: #selector(tappedSignUpButton), for: .touchUpInside)
        button.setAttributedTitle(attributedString, for: .normal)
        return button
    }()
    private lazy var loginButton: AuthButton = {
        let button = AuthButton(buttonTitle: "Log In")
        button.addTarget(self, action: #selector(tappedLoginButton), for: .touchUpInside)
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
    
    // MARK: - Selectors
    @objc func tappedSignUpButton() {
        let controller = SignupController()
        navigationController?.pushViewController(controller, animated: true)
    }
    
    @objc func tappedLoginButton() {
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        
        Service.logIn(email: email, password: password) { result, error in
            if let error = error {
                self.showAlert("Failed to log in", error.localizedDescription)
            }
            let keyWindow = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
            guard let controller = keyWindow?.rootViewController as? HomeController else { return }
            controller.configureView()
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    // MARK: - Methods
    func configureView() {
        [titleLabel, inputsStackView, signUpButton].forEach { view.addSubview($0) }
        
        [emailIconImageView, emailTextField].forEach { emailContainerView.addSubview($0) }
        [passwordIconImageView, passwordTextField].forEach { passwordContainerView.addSubview($0) }
        
        view.backgroundColor = .backgroundColor
        makeConstaints()
    }
    
    func makeConstaints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(12)
            make.centerX.equalToSuperview()
        }
        emailIconImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview()
            make.size.equalTo(CGSize(width: 24, height: 24))
        }
        emailTextField.snp.makeConstraints { make in
            make.leading.equalTo(emailIconImageView.snp.trailing).offset(8)
            make.trailing.equalToSuperview()
            make.centerY.equalTo(emailIconImageView)
        }
        passwordIconImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview()
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
            make.height.greaterThanOrEqualTo(160)
        }
        signUpButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(12)
            make.centerX.equalToSuperview()
        }
    }
}
