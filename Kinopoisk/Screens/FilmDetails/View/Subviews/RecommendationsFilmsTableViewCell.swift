//
//  RecommendationsFilmsTableViewCell.swift
//  Kinopoisk
//
//  Created by Евгений Фомичев on 15.06.2025.
//

import UIKit

protocol RecommendationsFilmsTableViewCellDelegate: AnyObject {
    func tappedSimilar(filmId: Int)
}

final class RecommendationsFilmsTableViewCell: UITableViewCell {
    
    
    static let cellidintifire = "RecommendationsFilmsTableViewCell"
    
    private let cashe = NSCache<NSString, UIImage>()
    private var films: [SimilarFilm] = []
    weak var delegate: RecommendationsFilmsTableViewCellDelegate?
    
    private let titleLabel: UILabel = {
       let titleLabel = UILabel()
        titleLabel.text = "Смотрите еще"
        titleLabel.textColor = .white
        titleLabel.font = .systemFont(ofSize: 22, weight: .bold)
        return titleLabel
    }()
    
    private lazy var filmsCollection: UICollectionView = {
       let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 120, height: 180)
        layout.minimumInteritemSpacing = 8
        
        let filmsCollection = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout
        )
        filmsCollection.register(
            RecommendationsFilmsCollectionCell.self,
            forCellWithReuseIdentifier: RecommendationsFilmsCollectionCell.cellidintifier
        )
        filmsCollection.delegate = self
        filmsCollection.dataSource = self
        filmsCollection.backgroundColor = .black
        return filmsCollection
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
        backgroundColor = .black
        contentView.addSubview(filmsCollection)
        contentView.addSubview(titleLabel)
    }
    
    private func setupConstraints() {
        titleLabel.addConstraints(constraints: [
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            titleLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 2/3)
        ])
        filmsCollection.addConstraints(constraints: [
            filmsCollection.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            filmsCollection.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            filmsCollection.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            filmsCollection.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            filmsCollection.heightAnchor.constraint(equalToConstant: 180)
        ])
    }
    
    func configure(films: [SimilarFilm]) {
        self.films = films
        filmsCollection.reloadData()
    }
}

extension RecommendationsFilmsTableViewCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        films.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecommendationsFilmsCollectionCell.cellidintifier, for: indexPath) as! RecommendationsFilmsCollectionCell
        
        let film = films[indexPath.item]
        cell.configure(film: film)
        return cell
    }
}

extension RecommendationsFilmsTableViewCell: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let film = films[indexPath.item]
        delegate?.tappedSimilar(filmId: film.filmId)
    }
}
