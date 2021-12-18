//
//  LocationInputActivationView.swift
//  uber-clone
//
//  Created by Динара Зиманова on 12/17/21.
//

import UIKit

protocol LocationInputActivationViewDelegate: class {
    func presentLocation()
}

class LocationInputActivationView: UIView {
    
    // MARK: - Internal properties
    weak var delegate: LocationInputActivationViewDelegate?
    
    // MARK: - Properties
    private lazy var indicatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    private lazy var placeholderLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = UIColor.darkGray
        label.text = "Where to?"
        return label
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
        addShadow()
        backgroundColor = .white
        [indicatorView, placeholderLabel].forEach { addSubview($0) }
        makeConstraints()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tappedInputView))
        addGestureRecognizer(tap)
    }
    
    func makeConstraints() {
        indicatorView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(16)
            make.size.equalTo(CGSize(width: 6, height: 6))
        }
        placeholderLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(indicatorView.snp.trailing).offset(20)
        }
    }
    
    @objc func tappedInputView() {
        delegate?.presentLocation()
    }
}
