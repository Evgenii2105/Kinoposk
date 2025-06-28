//
//  FilmListPesponce.swift
//  Kinopoisk
//
//  Created by Евгений Фомичев on 12.06.2025.
//

import Foundation

struct FilmListResponce: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case total = "total"
        case totalPages = "totalPages"
        case films = "items"
    }
    
    let total: Int?
    let totalPages: Int?
    let films: [Film]
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.total = try container.decodeIfPresent(Int.self, forKey: .total)
        self.totalPages = try container.decodeIfPresent(Int.self, forKey: .totalPages)
        self.films = try container.decode([Film].self, forKey: .films)
    }
}
