//
//  FilmDetailsInteractorimpl.swift
//  Kinopoisk
//
//  Created by Евгений Фомичев on 07.06.2025.
//

import UIKit

final class FilmDetailsInteractorimpl: FilmDetailsInteractor {
    
    weak var presenter: FilmDetailsPresenter?
    private let router: FilmDetailsRouter
    private let dataManagerService: DataManagerService = DataManagerServiceimpl()
    
    init(router: FilmDetailsRouter) {
        self.router = router
    }
    
    func setupDataSource() {
        presenter?.didDetailsFilms()
    }
    
    func makeFilmsSimilarFilms(filmId: Int) {
        dataManagerService.getFilmsDetails(filmId: filmId) { [weak self] result in
            guard let self else { return }
            
            DispatchQueue.main.async {
                switch result {
                case .success(let filmDetails):
                    self.router.showDetailsFilm(film: filmDetails)
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}
