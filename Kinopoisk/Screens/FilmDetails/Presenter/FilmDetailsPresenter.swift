//
//  FilmDetailsPresenter.swift
//  Kinopoisk
//
//  Created by Евгений Фомичев on 07.06.2025.
//

import Foundation

protocol FilmDetailsPresenter: AnyObject {
    func setupDataSource()
    func makeFilmsSimilarFilms(filmId: Int)
    func didDetailsFilms()
}
