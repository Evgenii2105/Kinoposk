//
//  DataManager.swift
//  Kinopoisk
//
//  Created by Евгений Фомичев on 07.06.2025.
//

import Foundation

protocol DataManagerService: AnyObject {
    func getFilms(filmsResult: @escaping (Result<[Film], Error>) -> Void)
    func getFilmsDetails(filmId: Int, filmDetailsResult: @escaping (Result<FilmDetails, Error>) -> Void)
}

class DataManagerServiceimpl: DataManagerService {
    
    private let client = Networkimpl()
    
    func getFilms(filmsResult: @escaping (Result<[Film], Error>) -> Void) {
        client.request(endPoint: .films) { (result: Result<FilmListResponce, NetworkError>) in
            switch result {
            case .success(let filmsListResponse):
                filmsResult(.success(filmsListResponse.films))
            case .failure(let error):
                filmsResult(.failure(NetworkError.decodingFailed(error)))
            }
        }
    }
    
    func getFilmsDetails(filmId: Int, filmDetailsResult: @escaping (Result<FilmDetails, Error>) -> Void) {
        client.request(endPoint: .detailsFilm(id: filmId)) { [weak self] (result: Result<FilmDetails,NetworkError>) in
            switch result {
            case .success(let filmDetails):
                guard let self else { return }
                self.client.request(endPoint: .picturesFilm(id: filmId)) { (result: Result<FilmPicturesResponce, NetworkError>) in
                    switch result {
                    case .success(let pictures):
                        var filmDetails = filmDetails
                        filmDetails.pictures = pictures.items
                        self.client.request(endPoint: .similarsFilm(id: filmId)) { (result: Result<FilmListResponce, NetworkError>) in
                            switch result {
                            case .success(let similarFilms):
                                filmDetails.similarFilms = similarFilms.films
                                filmDetailsResult(.success(filmDetails))
                            case .failure(let error):
                                filmDetailsResult(.failure(error))
                            }
                        }
                    case .failure(let error):
                        filmDetailsResult(.failure(NetworkError.decodingFailed(error)))
                    }
                }
            case .failure(let error):
                filmDetailsResult(.failure(NetworkError.decodingFailed(error)))
            }
        }
    }
}
