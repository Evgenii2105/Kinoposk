//
//  NetworkError.swift
//  Kinopoisk
//
//  Created by Евгений Фомичев on 07.06.2025.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case requestFailed(String)
    case noData
    case decodingFailed(Error)
}
