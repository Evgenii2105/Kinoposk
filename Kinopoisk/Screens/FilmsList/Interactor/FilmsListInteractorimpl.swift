//
//  FilmsListInteractorimpl.swift
//  Kinopoisk
//
//  Created by Евгений Фомичев on 07.06.2025.
//

import UIKit

final class FilmsListInteractorimpl: FilmsListInteractor {
    
    weak var presenter: FilmsListPresenter?
    private let router: FilmsListRouter
    
    init(router: FilmsListRouter) {
        self.router = router
    }
}
