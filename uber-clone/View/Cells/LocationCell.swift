//
//  SearchTableView.swift
//  uber-clone
//
//  Created by Динара Зиманова on 12/18/21.
//

import UIKit

class LocationCell: UITableViewCell {
    
    // MARK: - Properties
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .black
        label.text = "Location title"
        return label
    }()
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .darkGray
        label.text = "Location description"
        return label
    }()
    private lazy var labelStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, descriptionLabel])
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 4
        return stackView
    }()
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    func configureView() {
        selectionStyle = .none
        addSubview(labelStackView)
        makeConstaints()
    }
    
    func makeConstaints() {
        labelStackView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(12)
            make.centerY.equalToSuperview()
        }
    }
}
