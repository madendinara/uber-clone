//
//  LocationInputActivationView.swift
//  uber-clone
//
//  Created by Динара Зиманова on 12/17/21.
//

import UIKit

class LocationInputActivationView: UIView {
    
    // MARK: - Properties
    let indicatorView: UIView = {
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
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = .zero
        layer.masksToBounds = false
        backgroundColor = .white
        [indicatorView, placeholderLabel].forEach { addSubview($0) }
        makeConstraints()
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
}
