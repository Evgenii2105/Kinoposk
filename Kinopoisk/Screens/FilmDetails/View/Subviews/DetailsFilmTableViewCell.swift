//
//  DetailsFilmTabkeViewCell.swift
//  Kinopoisk
//
//  Created by Евгений Фомичев on 14.06.2025.
//

import UIKit

final class DetailsFilmTableViewCell: UITableViewCell {
    
    static let cellidintifire = "DetailsFilmTableViewCell"
    private var link: URL?
    
    private let titleLabel: UILabel = {
       let titleLabel = UILabel()
        titleLabel.text = "Описание"
        titleLabel.font = .systemFont(ofSize: 24, weight: .bold)
        titleLabel.textColor = .white
        return titleLabel
    }()
    
    private lazy var  linkButton: UIButton = {
        let linkButton = UIButton()
        let image = UIImage(systemName: "link")
        linkButton.setImage(image, for: .normal)
        linkButton.tintColor = .cyan
        linkButton.addAction(
            UIAction(handler: { [weak self] _ in
                self?.tappedLinkButton()
            })
            , for: .touchUpInside)
        return linkButton
    }()
    
    private let movieDescription: UILabel = {
       let movieDescription = UILabel()
        movieDescription.textColor = .white
        movieDescription.numberOfLines = 0
        return movieDescription
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func tappedLinkButton() {
        guard let link else { return }
        UIApplication.shared.open(link)
    }
    
    private func setupUI() {
        contentView.backgroundColor = .black
        contentView.addSubview(titleLabel)
        contentView.addSubview(linkButton)
        contentView.addSubview(movieDescription)
    }
    
    private func setupConstraints() {
        titleLabel.addConstraints(constraints: [
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: linkButton.leadingAnchor, constant: -8),
            titleLabel.heightAnchor.constraint(equalToConstant: 28)
        ])
        movieDescription.addConstraints(constraints: [
            movieDescription.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            movieDescription.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            movieDescription.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            movieDescription.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8)
        ])
        linkButton.addConstraints(constraints: [
            linkButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            linkButton.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 16),
            linkButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            linkButton.widthAnchor.constraint(equalToConstant: 26),
            linkButton.heightAnchor.constraint(equalToConstant: 26)
        ])
    }
    
    func configure(description: String?, link: URL?) {
        movieDescription.text = description
        self.link = link
    }
}
