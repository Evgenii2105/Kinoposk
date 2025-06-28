//
//  Untitled.swift
//  Kinopoisk
//
//  Created by Евгений Фомичев on 14.06.2025.
//

import Foundation

struct GenreItem {
    
    let genre: String
    
    init(genre: String) {
        self.genre = genre
    }
}

struct CountryItem {
    
    let country: String
    
    init(country: String) {
        self.country = country
    }
}

struct SimilarFilm {
    let filmId: Int
    let name: String
    let preview: URL?
}

enum FilmDetailCellType {
    case movieHeaderPicture(
        imageURL: URL?,
        name: String?,
        rating: Decimal
    )
    case description(
        link: URL?,
        description: String?
    )
    case genreAndYear(
        genres: [GenreItem],
        startYear: Int?,
        endYear: Int?,
        country: [CountryItem],
        year: Int?
    )
    case pictures(imagesNames: [URL])
    case similarMovies(films: [SimilarFilm])
}




