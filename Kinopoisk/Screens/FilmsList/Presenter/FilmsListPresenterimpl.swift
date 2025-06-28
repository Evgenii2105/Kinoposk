//
//  FilmsListPresenterimpl.swift
//  Kinopoisk
//
//  Created by Евгений Фомичев on 07.06.2025.
//

import UIKit

final class FilmsListPresenterimpl: FilmsListPresenter {
    
    weak var view: FilmsListViewController?
    private let interactor: FilmsListInteractor
    
    init(view: FilmsListViewController, interactor: FilmsListInteractor) {
        self.view = view
        self.interactor = interactor
    }
    
    func setupDataSource() {
        interactor.setupDataSource()
    }
    
    func showDetailsFilm(film: FilmsListItem) {
        interactor.showDetailsFilm(film: film)
    }
    
    func performLogaut() {
        interactor.performLogaut()
    }
    
    func searchFilms(with query: String?) {
        interactor.searchFilms(with: query)
    }
    
    func sort(by film : FilmsListViewController.FilmSorting) {
        interactor.sort(by: film)
    }
    
    func filter(by year: GenericPickerViewController.YearFilter) {
        interactor.filter(by: year)
    }
}

extension FilmsListPresenterimpl: FilmsListPresenterOutput {
    
    func didFilms(films: [FilmsListItem]) {
        view?.didFilms(films: films)
    }
}
