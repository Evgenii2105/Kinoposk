//
//  PicturesCollectionCell.swift
//  Kinopoisk
//
//  Created by Евгений Фомичев on 15.06.2025.
//

import UIKit

final class PicturesCollectionCell: UICollectionViewCell {
    
    static let identifier = "PicturesCollectionCell"
    private static let cashe = NSCache<NSURL, UIImage>()
    private var imageURL: URL?
    
    private let imageView: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        imageView.frame = contentView.bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with imageURl: URL) {
        self.imageURL = imageURl
        
        if let image = Self.cashe.object(forKey: imageURl as NSURL) {
            imageView.image = image
        } else {
            imageView.image = UIImage(systemName: "photo")?.withTintColor(.lightGray)
            Networkimpl.downloadImage(from: imageURl) { [weak self] image in
                guard let self = self else { return }
                
                if let image = image {
                    Self.cashe.setObject(image, forKey: imageURl as NSURL)
                    DispatchQueue.main.async {
                        if imageURl == self.imageURL {
                            self.imageView.image = image
                        }
                    }
                }
            }
        }
    }
}
