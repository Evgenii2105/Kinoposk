//
//  GenreYearTableViewCell.swift
//  Kinopoisk
//
//  Created by Евгений Фомичев on 15.06.2025.
//

import UIKit

final class GenreYearTableViewCell: UITableViewCell {
    
    static let cellidintifire = "GenreYearTableViewCell"
    
    private let genreLabel: UILabel = {
        let genreLabel = UILabel()
        genreLabel.numberOfLines = 0
        genreLabel.textColor = .lightGray
        return genreLabel
    }()
    
    private let yearLabel: UILabel = {
        let yearLabel = UILabel()
        yearLabel.numberOfLines = 0
        yearLabel.textColor = .lightGray
        return yearLabel
    }()
    
    private let countryLabel: UILabel = {
        let countryLabel = UILabel()
        countryLabel.textColor = .lightGray
        countryLabel.numberOfLines = 0
        return countryLabel
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
        contentView.addSubview(genreLabel)
        contentView.addSubview(yearLabel)
        contentView.addSubview(countryLabel)
    }
    
    private func setupConstraints() {
        genreLabel.addConstraints(constraints: [
            genreLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            genreLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            genreLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8)
        ])
        yearLabel.addConstraints(constraints: [
            yearLabel.topAnchor.constraint(equalTo: genreLabel.bottomAnchor, constant: 8),
            yearLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            yearLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            yearLabel.trailingAnchor.constraint(lessThanOrEqualTo: countryLabel.leadingAnchor, constant: -8),
        ])
        countryLabel.addConstraints(constraints: [
            countryLabel.topAnchor.constraint(equalTo: genreLabel.bottomAnchor, constant: 8),
            countryLabel.leadingAnchor.constraint(equalTo: yearLabel.trailingAnchor, constant: 8),
            countryLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            countryLabel.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -8)
        ])
    }
    
    func configure(
        genres: [GenreItem],
        countries: [CountryItem],
        startYear: Int?,
        
        endYear: Int?,
        year: Int?
    ) {
        genreLabel.text = genres.map({ $0.genre }).joined(separator: ", ")
        countryLabel.text = countries.map({ $0.country }).joined(separator: ", ")
        var yearText = ""
        
        if let year = year {
            if yearText.isEmpty {
                yearText += "\(year)"
            }
        }
        
        if let startYear = startYear {
            if yearText.isEmpty {
                yearText += "\(startYear)"
            }
        }
        if let endYear = endYear {
            if !yearText.isEmpty {
                yearText += " - "
                yearText += "\(endYear)"
            }
        }
        yearLabel.text = "\(yearText)"
    }
}
