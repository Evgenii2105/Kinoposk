//
//  Country.swift
//  Kinopoisk
//
//  Created by Евгений Фомичев on 12.06.2025.
//

import Foundation

struct Country: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case country = "country"
    }
    
    let country: String
}
