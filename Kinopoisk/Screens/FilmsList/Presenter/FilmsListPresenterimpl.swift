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
}
