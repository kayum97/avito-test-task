//
//  MainCollectionViewCell.swift
//  avito
//
//  Created by Admin on 29.12.2020.
//

import UIKit

class MainTableViewCell: UITableViewCell {
    static let identifierForTableView = "identifierForTableView"
    
    var data: ProposalModel? {
        didSet {
            var url: URL?
            if let iconUrlString = data?.icon["52x52"] {
                url = URL(string: iconUrlString)
            }
            iconImageView.downloadImage(withURL: url)
            titleLabel.text = data?.title
            descriptionLabel.text = data?.description
            priceLabel.text = data?.price
            selectedImageView.isHidden = !(data?.isSelected ?? false)
        }
    }
    
    private var containerView = UIView()
    
    private var iconImageView = UIImageView()
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    private var descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    private var priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    
    private var selectedImageView = UIImageView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        containerView.backgroundColor = .lightGrey
        configureUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureUI() {
        selectionStyle = .none
        
        containerView.layer.cornerRadius = 5.0
        containerView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(containerView)
        
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(iconImageView)

        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.translatesAutoresizingMaskIntoConstraints = false

        containerView.addSubview(titleLabel)
        containerView.addSubview(descriptionLabel)
        containerView.addSubview(priceLabel)
        
        selectedImageView.translatesAutoresizingMaskIntoConstraints = false
        selectedImageView.image = UIImage(systemName: "checkmark.circle.fill")
        containerView.addSubview(selectedImageView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5)
        ])
        
        NSLayoutConstraint.activate([
            iconImageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20),
            iconImageView.widthAnchor.constraint(equalToConstant: 50),
            iconImageView.heightAnchor.constraint(equalToConstant: 50),
            iconImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 15)
        ])

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: containerView.layoutMarginsGuide.topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 15),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -55)
        ])

        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            descriptionLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 15),
            descriptionLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -55)
        ])

        NSLayoutConstraint.activate([
            priceLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 15),
            priceLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 15),
            priceLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -55),
            priceLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            selectedImageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20),
            selectedImageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            selectedImageView.widthAnchor.constraint(equalToConstant: 25),
            selectedImageView.heightAnchor.constraint(equalToConstant: 25)
        ])
    }
}
