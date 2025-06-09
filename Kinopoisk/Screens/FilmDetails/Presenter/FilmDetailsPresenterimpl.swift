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
    
    init(interactor: FilmDetailsInteractor) {
        self.interactor = interactor
    }
}
