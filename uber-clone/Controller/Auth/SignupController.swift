//
//  SignupController.swift
//  uber-clone
//
//  Created by Динара Зиманова on 12/14/21.
//

import UIKit
import Firebase
import FirebaseDatabase

class SignupController: UIViewController {
    
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
    private lazy var fullnameTextField = AuthInputTextField(placeholderText: "Full Name", isSecure: false)
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
    private lazy var fullnameContainerView: InputView = {
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
    private lazy var fullnameIconImageView: UIImageView = {
        let imageView =  UIImageView()
        imageView.image = UIImage(named: "ic_person_outline_white_2x")
        imageView.alpha = 0.8
        return imageView
    }()
    private lazy var accountTypeIconImageView: UIImageView = {
        let imageView =  UIImageView()
        imageView.image = UIImage(named: "ic_account_box_white_2x")
        imageView.alpha = 0.8
        return imageView
    }()
    private lazy var accountTypeSegmentedControl: UISegmentedControl = {
        let control = UISegmentedControl(items: ["Rider", "Driver"])
        control.backgroundColor = .backgroundColor
        control.selectedSegmentIndex = 0
        control.tintColor = .red
        control.selectedSegmentTintColor = UIColor.init(white: 1, alpha: 0.8)
        
        let titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.init(white: 1, alpha: 0.8)]
        control.setTitleTextAttributes(titleTextAttributes, for: .normal)
        
        control.layer.cornerRadius = 5
        return control
    }()
    private lazy var accountTypeContainerView: InputView = {
        let view = InputView()
        view.heightAnchor.constraint(equalToConstant: 80).isActive = true
        return view
    }()
    private lazy var inputsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [emailContainerView, passwordContainerView, fullnameContainerView, accountTypeContainerView, signupButton])
        stackView.distribution = .fillProportionally
        stackView.axis = .vertical
        stackView.spacing = 16
        return stackView
    }()
    private lazy var loginButton: UIButton = {
        let button = UIButton(type: .system)
        
        let attributedString = NSMutableAttributedString.init(string: "Already have an account? ", attributes: [.font: UIFont.systemFont(ofSize: 14), .foregroundColor: UIColor.lightGray])
        attributedString.append(NSAttributedString(string: "Sign In", attributes: [.font: UIFont.boldSystemFont(ofSize: 14), .foregroundColor: UIColor.mainBlue]))
        
        button.addTarget(self, action: #selector(tappedLoginButton), for: .touchUpInside)
        button.setAttributedTitle(attributedString, for: .normal)
        return button
    }()
    private lazy var signupButton: AuthButton = {
        let button = AuthButton(buttonTitle: "Sign Up")
        button.addTarget(self, action: #selector(tappedSignUpButton), for: .touchUpInside)
        return button
    }()
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    // MARK: - Selectors
    @objc func tappedLoginButton() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func tappedSignUpButton() {
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        guard let fullname = fullnameTextField.text else { return }
        let accountType = accountTypeSegmentedControl.selectedSegmentIndex
        
        Service.signUp(email: email, password: password, fullname: fullname, accountType: accountType) { result, error in
            if let error = error {
                self.showAlert("Failed to sign up", error.localizedDescription)
                return
            }
            let keyWindow = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
            guard let controller = keyWindow?.rootViewController as? HomeController else { return }
            controller.configureView()
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    // MARK: - Methods
    func configureView() {
        [titleLabel, inputsStackView, loginButton].forEach { view.addSubview($0) }
        view.backgroundColor = .backgroundColor
        
        [emailIconImageView, emailTextField].forEach { emailContainerView.addSubview($0) }
        [passwordIconImageView, passwordTextField].forEach { passwordContainerView.addSubview($0) }
        [fullnameIconImageView, fullnameTextField].forEach { fullnameContainerView.addSubview($0) }
        [accountTypeIconImageView, accountTypeSegmentedControl].forEach { accountTypeContainerView.addSubview($0) }
        
        makeConstraints()
    }
    
    func makeConstraints() {
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
        fullnameIconImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview()
            make.size.equalTo(CGSize(width: 24, height: 24))
        }
        fullnameTextField.snp.makeConstraints { make in
            make.leading.equalTo(fullnameIconImageView.snp.trailing).offset(8)
            make.trailing.equalToSuperview()
            make.centerY.equalTo(fullnameIconImageView)
        }
        accountTypeIconImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(4)
            make.leading.equalToSuperview()
            make.size.equalTo(CGSize(width: 24, height: 24))
        }
        accountTypeSegmentedControl.snp.makeConstraints { make in
            make.top.equalTo(accountTypeIconImageView.snp.bottom).offset(4)
            make.leading.trailing.equalToSuperview()
        }
        inputsStackView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(40)
            make.centerX.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.greaterThanOrEqualTo(200)
        }
        loginButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(12)
            make.centerX.equalToSuperview()
        }
    }
}
