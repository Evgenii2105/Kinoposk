//
//  FilmsListCell.swift
//  Kinopoisk
//
//  Created by Евгений Фомичев on 09.06.2025.
//

import UIKit

class FilmsListCell: UITableViewCell {
    
    static let cellidentifire = "FilmsListCell"
    private static let cashe = NSCache<NSURL, UIImage>()
    
    private let imageFilm: UIImageView = {
        let imageFilm = UIImageView()
        imageFilm.image = UIImage(systemName: "photo")
        imageFilm.tintColor = .blue
        return imageFilm
    }()
    
    private let nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textColor = .lightGray
        nameLabel.text = "nameLabel"
        nameLabel.textAlignment = .center
        nameLabel.backgroundColor = .black
        nameLabel.numberOfLines = 0
        nameLabel.lineBreakMode = .byWordWrapping
        nameLabel.font = .systemFont(ofSize: 16, weight: .bold)
        return nameLabel
    }()
    
    private let genreLabel: UILabel = {
        let genreLabel = UILabel()
        genreLabel.numberOfLines = 0
        genreLabel.text = "genre"
        genreLabel.textAlignment = .center
        genreLabel.font = .systemFont(ofSize: 14, weight: .light)
        genreLabel.textColor = .lightGray
        genreLabel.lineBreakMode = .byWordWrapping
        genreLabel.backgroundColor = .black
        return genreLabel
    }()
    
    private let detailsLabel: UILabel = {
        let detailsLabel = UILabel()
        detailsLabel.font = .systemFont(ofSize: 14)
        detailsLabel.text = "details"
        detailsLabel.textColor = .lightGray
        detailsLabel.numberOfLines = 0
        detailsLabel.textAlignment = .center
        detailsLabel.lineBreakMode = .byWordWrapping
        return detailsLabel
    }()
    
    private let ratingLabel: UILabel = {
        let ratingLabel = UILabel()
        ratingLabel.font = .systemFont(ofSize: 16, weight: .bold)
        ratingLabel.textColor = .cyan
        ratingLabel.text = "rating"
        ratingLabel.textAlignment = .center
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
        contentView.addSubview(imageFilm)
        contentView.addSubview(nameLabel)
        contentView.addSubview(genreLabel)
        contentView.addSubview(detailsLabel)
        contentView.addSubview(ratingLabel)
    }
    
    private func setupConstraints() {
        imageFilm.addConstraints(constraints: [
            imageFilm.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            imageFilm.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            imageFilm.heightAnchor.constraint(equalToConstant: 120),
            imageFilm.widthAnchor.constraint(equalToConstant: 80)
        ])
        nameLabel.addConstraints(constraints: [
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: imageFilm.trailingAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -92)
        ])
        genreLabel.addConstraints(constraints: [
            genreLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            genreLabel.leadingAnchor.constraint(equalTo: imageFilm.trailingAnchor, constant: 16),
            genreLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])
        detailsLabel.addConstraints(constraints: [
            detailsLabel.topAnchor.constraint(equalTo: genreLabel.bottomAnchor, constant: 8),
            detailsLabel.leadingAnchor.constraint(equalTo: imageFilm.trailingAnchor, constant: 16),
            detailsLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -16),
            detailsLabel.trailingAnchor.constraint(equalTo: ratingLabel.leadingAnchor, constant: -16)
        ])
        ratingLabel.addConstraints(constraints: [
            ratingLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            ratingLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            ratingLabel.widthAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    func configure(with film: FilmsListItem) {
        nameLabel.text = film.name
        genreLabel.text = film.genres.map({ $0.genre }).joined(separator: ", ")
        let country = film.countries.map({ $0.country }).joined(separator: ", ")
        ratingLabel.text = "\(film.ratingKinopoisk)"
        detailsLabel.text = "\(film.year) * \(country)"
        
        guard let imageURL = film.posterUrlPreview else {
            imageFilm.image = nil
            return
        }
        
        if let image = Self.cashe.object(forKey: film.posterUrlPreview! as NSURL) {
            imageFilm.image = image
        } else {
            imageFilm.image = UIImage(systemName: "placeolder")
            Networkimpl.downloadImage(from: imageURL) { [weak self] image in
                guard let self else { return }
                
                if let downloadImage = image {
                    Self.cashe.setObject(downloadImage, forKey: imageURL as NSURL)
                    
                    DispatchQueue.main.async {
                        if self.nameLabel.text == film.name {
                            self.imageFilm.image = downloadImage
                        }
                    }
                }
            }
        }
    }
}
