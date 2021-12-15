//
//  InputView.swift
//  uber-clone
//
//  Created by Динара Зиманова on 12/14/21.
//

import UIKit

class InputView: UIView {
    
    // MARK: - Init
    init() {
        super.init(frame: .zero)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    func configureView() {
        let separator = UIView()
        separator.backgroundColor = .lightGray
        addSubview(separator)
        separator.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(0.5)
        }
    }
}
