//
//  FilmsListInteractorimpl.swift
//  Kinopoisk
//
//  Created by Евгений Фомичев on 07.06.2025.
//

import UIKit

final class FilmsListInteractorimpl: FilmsListInteractor {
    
    weak var presenter: FilmsListPresenterOutput?
    private let router: FilmsListRouter
    private let dataManager: DataManagerService = DataManagerServiceimpl()
    private var films: [FilmsListItem] = []
    
    init(router: FilmsListRouter) {
        self.router = router
    }
    
    func setupDataSource() {
        dataManager.getFilms { [ weak self] result in
            guard let self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let films):
                    self.films = films.map({ $0.toListItem() })
                    self.presenter?.didFilms(films: self.films)
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    func showDetailsFilm(film: FilmsListItem) {
        dataManager.getFilmsDetails(filmId: film.kinopoiskId) { [weak self] result in
            guard let self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let film):
                    self.router.showDetailsFilm(film: film)
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    func searchFilms(with query: String?) {
        guard let query = query, !query.isEmpty else {
            presenter?.didFilms(films: films)
            return
        }
        let queryLow = query.lowercased()
        
        let filterFilms = films.filter({ film in
            let filterByName = film.name?.lowercased().contains(queryLow) ?? false
            let filterByGenre = film.genres.contains(where: { $0.genre.contains(queryLow) })
            let filterByCountry = film.countries.contains(where: { $0.country.contains(queryLow) })
            
            return filterByName || filterByGenre || filterByCountry
        })
        presenter?.didFilms(films: filterFilms)
    }
    
    func sort(by film: FilmsListViewController.FilmSorting) {
        var sortedFilms = films
        switch film {
        case .sortedDefault:
                break
        case .sortedDescending:
            sortedFilms = films.sorted(by: { $0.ratingKinopoisk > $1.ratingKinopoisk })
        case .sortedAscending:
            sortedFilms = films.sorted(by: { $0.ratingKinopoisk < $1.ratingKinopoisk })
        }
        presenter?.didFilms(films: sortedFilms)
    }
    
    func filter(by year: GenericPickerViewController.YearFilter) {
        var filterFilms = films
        switch year {
        case .allYears:
            break
        case .specificYear(let year):
            filterFilms = films.filter({ $0.year == year })
        }
        presenter?.didFilms(films: filterFilms)
    }
    
    func performLogaut() {
        router.exitScreen()
    }
}
