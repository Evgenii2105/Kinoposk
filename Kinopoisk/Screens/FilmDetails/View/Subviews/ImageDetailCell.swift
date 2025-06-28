//
//  ImageDetailCell.swift
//  Kinopoisk
//
//  Created by Евгений Фомичев on 14.06.2025.
//

import UIKit

final class ImageDetailCell: UITableViewCell {
    
    static let cellidentifire = "ImageDetailCell"
    
    private let imageFilms: UIImageView = {
        let imageFilms = UIImageView()
        imageFilms.contentMode = .scaleAspectFill
        imageFilms.clipsToBounds = true
        return imageFilms
    }()
    
    private let nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.numberOfLines = 0
        nameLabel.textColor = .white
        nameLabel.font = .systemFont(ofSize: 22, weight: .bold)
        return nameLabel
    }()
    
    private let ratingLabel: UILabel = {
        let ratingLabel = UILabel()
        ratingLabel.textColor = .cyan
        return ratingLabel
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.backgroundColor = .black
        contentView.addSubview(imageFilms)
        contentView.addSubview(nameLabel)
        contentView.addSubview(ratingLabel)
    }
    
    private func setupConstraints() {
        imageFilms.addConstraints(constraints: [
            imageFilms.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageFilms.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageFilms.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            imageFilms.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageFilms.heightAnchor.constraint(equalToConstant: 470)
        ])
        nameLabel.addConstraints(constraints: [
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            nameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            nameLabel.widthAnchor.constraint(lessThanOrEqualTo: contentView.widthAnchor, multiplier: 0.7)
        ])
        ratingLabel.addConstraints(constraints: [
            ratingLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            ratingLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            ratingLabel.widthAnchor.constraint(equalToConstant: 40),
            ratingLabel.heightAnchor.constraint(equalToConstant: 25)
            
        ])
    }
    
    func configure(name: String?, imageURL: URL?, rating: Decimal) {
        nameLabel.text = name
        ratingLabel.text = "\(rating)"
        
        if let imageURL = imageURL {
            Networkimpl.downloadImage(from: imageURL) { [weak self] image in
                DispatchQueue.main.async {
                    self?.imageFilms.image = image ?? UIImage(systemName: "play.rectangle.fill")
                }
            }
        }
    }
}
