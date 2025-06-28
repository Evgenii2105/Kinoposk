//
//  FilmsListView.swift
//  Kinopoisk
//
//  Created by Евгений Фомичев on 07.06.2025.
//

import Foundation

protocol FilmsListView: AnyObject {
    func didFilms(films: [FilmsListItem])
}
