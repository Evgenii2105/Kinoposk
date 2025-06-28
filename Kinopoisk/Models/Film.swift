//
//  Film.swift
//  Kinopoisk
//
//  Created by Евгений Фомичев on 12.06.2025.
//

import Foundation

struct Film: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case kinopoiskId = "kinopoiskId"
        case imdbId = "imdbId"
        case nameRu = "nameRu"
        case nameEn = "nameEn"
        case nameOriginal = "nameOriginal"
        case countries = "countries"
        case genres = "genres"
        case ratingKinopoisk = "ratingKinopoisk"
        case ratingImdb = "ratingImdb"
        case year = "year"
        case type = "type"
        case posterUrl = "posterUrl"
        case posterUrlPreview = "posterUrlPreview"
        case filmId = "filmId"
    }
    
    let kinopoiskId: Int
    let imdbId: String?
    let nameRu: String?
    let nameEn: String?
    let nameOriginal: String?
    let countries: [Country]
    let genres: [Genre]
    let ratingKinopoisk: Decimal
    let ratingImdb: Decimal?
    let year: Int
    let type: String
    let posterUrl: URL?
    let posterUrlPreview: URL?
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        if let kinopoiskId = try container.decodeIfPresent(Int.self, forKey: .kinopoiskId) {
            self.kinopoiskId = kinopoiskId
        } else if let filmId = try container.decodeIfPresent(Int.self, forKey: .filmId) {
            self.kinopoiskId = filmId
        } else {
            kinopoiskId = 0
        }
        
        self.imdbId = try container.decodeIfPresent(String.self, forKey: .imdbId)
        self.nameRu = try container.decodeIfPresent(String.self, forKey: .nameRu)
        self.nameEn = try container.decodeIfPresent(String.self, forKey: .nameEn)
        self.nameOriginal = try container.decodeIfPresent(String.self, forKey: .nameOriginal)
        self.countries = try container.decodeIfPresent([Country].self, forKey: .countries) ?? []
        self.genres = try container.decodeIfPresent([Genre].self, forKey: .genres) ?? []
        self.ratingKinopoisk = try container.decodeIfPresent(Decimal.self, forKey: .ratingKinopoisk) ?? 0
        self.ratingImdb = try container.decodeIfPresent(Decimal.self, forKey: .ratingImdb)
        self.year = try container.decodeIfPresent(Int.self, forKey: .year) ?? 2000
        self.type = try container.decodeIfPresent(String.self, forKey: .type) ?? ""
        self.posterUrl = try container.decodeIfPresent(URL.self, forKey: .posterUrl)
        self.posterUrlPreview = try container.decodeIfPresent(URL.self, forKey: .posterUrlPreview)
    }
}

extension Film {
    
    func toListItem() -> FilmsListItem {
      return FilmsListItem(
        kinopoiskId: kinopoiskId,
        name: nameRu ?? nameOriginal ?? nameEn,
        countries: countries.map({ CountryItem(country: $0.country) }),
        genres: genres.map({ GenreItem(genre: $0.genre) }),
        ratingKinopoisk: ratingKinopoisk,
        year: year,
        posterUrlPreview: posterUrlPreview
      )
    }
}
