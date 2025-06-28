//
//  RecommendationsFilmsCollectionCell.swift
//  Kinopoisk
//
//  Created by Евгений Фомичев on 15.06.2025.
//

import UIKit

final class RecommendationsFilmsCollectionCell: UICollectionViewCell {
    
    static let cellidintifier = "RecommendationsFilmsCollectionCell"
    private static let cashe = NSCache<NSURL, UIImage>()
    private var imageUrl: [SimilarFilm]?
    
    private let nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textColor = .white
        nameLabel.numberOfLines = 2
        nameLabel.font = .systemFont(ofSize: 14)
        nameLabel.lineBreakMode = .byTruncatingTail
        nameLabel.textAlignment = .center
        return nameLabel
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .white
        imageView.image = UIImage(systemName:  "photo.on.rectangle")
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        contentView.addSubview(nameLabel)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        imageView.addConstraints(constraints: [
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 150),
            imageView.heightAnchor.constraint(equalToConstant: 120)
        ])
        nameLabel.addConstraints(constraints: [
            nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8),
            nameLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            nameLabel.widthAnchor.constraint(equalToConstant: 120)
        ])
    }
    
    func configure(film: SimilarFilm) {
        if let imageUrl = film.preview {
            Networkimpl.downloadImage(from: imageUrl) { [weak self] image in
                DispatchQueue.main.async {
                    self?.imageView.image = image ?? UIImage(systemName: "play.rectangle.fill")
                    self?.nameLabel.text = film.name
                }
            }
        }
    }
}
