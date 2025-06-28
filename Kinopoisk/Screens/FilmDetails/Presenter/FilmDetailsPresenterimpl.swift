//
//  FilmDetailsPresenterimpl.swift
//  Kinopoisk
//
//  Created by Евгений Фомичев on 07.06.2025.
//

import UIKit

final class FilmDetailsPresenterimpl: FilmDetailsPresenter {
    
    weak var view: FilmDetailsView?
    private let interactor: FilmDetailsInteractor
    private let filmDetails: FilmDetails
    
    init(view: FilmDetailsView, interactor: FilmDetailsInteractor, filmDetails: FilmDetails) {
        self.view = view
        self.interactor = interactor
        self.filmDetails = filmDetails
    }
    
    func setupDataSource() {
        interactor.setupDataSource()
    }
    
    func didDetailsFilms() {
        view?.showFilmDetails(cellTypes: filmDetails.toCellTypes())
    }
    
    func makeFilmsSimilarFilms(filmId: Int) {
        interactor.makeFilmsSimilarFilms(filmId: filmId)
    }
}
