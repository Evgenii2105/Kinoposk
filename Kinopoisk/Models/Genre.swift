//
//  Genre.swift
//  Kinopoisk
//
//  Created by Евгений Фомичев on 12.06.2025.
//

import Foundation

struct Genre: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case genre = "genre"
    }
    
    let genre: String
}
