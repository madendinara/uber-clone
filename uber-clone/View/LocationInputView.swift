//
//  LocationInputView.swift
//  uber-clone
//
//  Created by Динара Зиманова on 12/18/21.
//

import UIKit

protocol LocationInputViewDelegate: class {
    func dismissView()
}

class LocationInputView: UIView {
    
    // MARK: - Internal properties
    weak var delegate: LocationInputViewDelegate?
    
    // MARK: - Properties
    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "baseline_arrow_back_black_36dp")?.withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(tappedBackButton), for: .touchUpInside)
        return button
    }()
    private lazy var nameTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Dinara"
        label.textColor = .darkGray
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    private lazy var fromIndicatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.layer.cornerRadius = 3
        return view
    }()
    private lazy var linkingView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    private lazy var toIndicatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .darkGray
        return view
    }()
    private lazy var fromTextField = LocationInputTextField(placeholderText: "Current Location", isEnable: false, backColor: .systemGray6)
    private lazy var toTextField = LocationInputTextField(placeholderText: "Enter a destination..", isEnable: true, backColor: .lightGray)
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    func configureView() {
        backgroundColor = .white
        addShadow()
        [backButton, nameTitleLabel, fromIndicatorView, linkingView, toIndicatorView, fromTextField, toTextField].forEach { addSubview($0) }
        makeConstraints()
    }
    
    func makeConstraints() {
        backButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(44)
            make.leading.equalToSuperview().inset(12)
            make.size.equalTo(CGSize(width: 24, height: 24))
        }
        nameTitleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalTo(backButton)
        }
        fromTextField.snp.makeConstraints { make in
            make.top.equalTo(backButton.snp.bottom).offset(8)
            make.trailing.equalToSuperview().inset(20)
            make.leading.equalToSuperview().inset(32)
            make.height.equalTo(30)
        }
        toTextField.snp.makeConstraints { make in
            make.top.equalTo(fromTextField.snp.bottom).offset(12)
            make.trailing.equalToSuperview().inset(20)
            make.leading.equalToSuperview().inset(32)
            make.height.equalTo(30)
        }
        fromIndicatorView.snp.makeConstraints { make in
            make.centerY.equalTo(fromTextField)
            make.centerX.equalTo(backButton)
            make.size.equalTo(CGSize(width: 6, height: 6))
        }
        toIndicatorView.snp.makeConstraints { make in
            make.centerY.equalTo(toTextField)
            make.centerX.equalTo(linkingView)
            make.size.equalTo(CGSize(width: 6, height: 6))
        }
        linkingView.snp.makeConstraints { make in
            make.top.equalTo(fromIndicatorView.snp.bottom)
            make.bottom.equalTo(toIndicatorView.snp.top)
            make.centerX.equalTo(fromIndicatorView)
            make.width.equalTo(0.5)
        }
    }
    
    @objc func tappedBackButton() {
        delegate?.dismissView()
    }
}
