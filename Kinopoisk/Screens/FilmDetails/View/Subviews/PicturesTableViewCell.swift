//
//  PicturesTableViewCell.swift
//  Kinopoisk
//
//  Created by Евгений Фомичев on 15.06.2025.
//

import UIKit

final class PicturesTableViewCell: UITableViewCell {
    
    static let cellidintifire = "PicturesTableViewCell"
    private var imageURLs: [URL] = []
    
    private let picturesLabel: UILabel = {
        let picturesLabel = UILabel()
        picturesLabel.text = "Кадры"
        picturesLabel.textColor = .white
        picturesLabel.font = .systemFont(ofSize: 22, weight: .bold)
        return picturesLabel
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 120, height: 80)
        layout.minimumLineSpacing = 8
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(PicturesCollectionCell.self, forCellWithReuseIdentifier: PicturesCollectionCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .clear
        return collectionView
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
        contentView.addSubview(picturesLabel)
        contentView.addSubview(collectionView)
    }
    
    private func setupConstraints() {
        picturesLabel.addConstraints(constraints: [
            picturesLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            picturesLabel.bottomAnchor.constraint(equalTo: collectionView.topAnchor, constant: -8)
        ])
        collectionView.addConstraints(constraints: [
            collectionView.topAnchor.constraint(equalTo: picturesLabel.bottomAnchor, constant: 8),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            collectionView.heightAnchor.constraint(equalToConstant: 80)
        ])
    }
    
    func configure(with urls: [URL]) {
        self.imageURLs = urls
        collectionView.reloadData()
    }
}

extension PicturesTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageURLs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PicturesCollectionCell.identifier, for: indexPath) as? PicturesCollectionCell else {
            return UICollectionViewCell()
        }
        let imageUrl = imageURLs[indexPath.item]
        cell.configure(with: imageUrl)
        
        return cell
    }
}
