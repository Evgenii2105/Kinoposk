//
//  FilmsListRouter.swift
//  Kinopoisk
//
//  Created by Евгений Фомичев on 07.06.2025.
//

import Foundation

protocol FilmsListRouter: AnyObject {
    func showDetailsFilm(film: FilmDetails)
    func exitScreen() 
}
