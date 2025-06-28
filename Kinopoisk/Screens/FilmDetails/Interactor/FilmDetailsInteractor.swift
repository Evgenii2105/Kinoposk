//
//  FilmDetailsInteractor.swift
//  Kinopoisk
//
//  Created by Евгений Фомичев on 07.06.2025.
//

import Foundation

protocol FilmDetailsInteractor: AnyObject {
    func setupDataSource()
    func makeFilmsSimilarFilms(filmId: Int)
}
