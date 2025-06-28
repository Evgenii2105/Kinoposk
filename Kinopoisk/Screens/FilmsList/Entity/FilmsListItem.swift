//
//  FilmsListItem.swift
//  Kinopoisk
//
//  Created by Евгений Фомичев on 12.06.2025.
//

import Foundation

struct FilmsListItem {
    let kinopoiskId: Int
    let name: String?
    let countries: [CountryItem]
    let genres: [GenreItem]
    let ratingKinopoisk: Decimal
    let year: Int
    let posterUrlPreview: URL?
}
