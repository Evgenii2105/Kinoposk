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
    
    init(router: FilmDetailsRouter) {
        self.router = router
    }
}
