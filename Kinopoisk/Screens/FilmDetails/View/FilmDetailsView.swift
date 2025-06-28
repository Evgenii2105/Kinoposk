//
//  FilmDetailsView.swift
//  Kinopoisk
//
//  Created by Евгений Фомичев on 07.06.2025.
//

import Foundation

protocol FilmDetailsView: AnyObject {
    func showFilmDetails(cellTypes: [FilmDetailCellType])
}
