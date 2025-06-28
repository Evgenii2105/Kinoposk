//
//  FilmsListPresenter.swift
//  Kinopoisk
//
//  Created by Евгений Фомичев on 07.06.2025.
//

import Foundation

protocol FilmsListPresenter: AnyObject {
    func setupDataSource()
    func showDetailsFilm(film: FilmsListItem)
    func searchFilms(with query: String?)
    func sort(by film: FilmsListViewController.FilmSorting)
    func filter(by year: GenericPickerViewController.YearFilter)
    func performLogaut()
}

protocol FilmsListPresenterOutput: AnyObject {
    func didFilms(films: [FilmsListItem])
}
