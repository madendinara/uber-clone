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
        [backButton].forEach { addSubview($0) }
        makeConstraints()
    }
    
    func makeConstraints() {
        backButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(44)
            make.leading.equalToSuperview().inset(12)
            make.size.equalTo(CGSize(width: 24, height: 24))
        }
    }
    
    @objc func tappedBackButton() {
        delegate?.dismissView()
    }
}
