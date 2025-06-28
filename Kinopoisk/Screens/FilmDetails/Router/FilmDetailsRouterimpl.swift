//
//  FilmDetailsRouterimpl.swift
//  Kinopoisk
//
//  Created by Евгений Фомичев on 07.06.2025.
//

import UIKit

final class FilmDetailsRouterimpl: FilmDetailsRouter {
   
    weak var viewController: UIViewController?
    
    func showDetailsFilm(film: FilmDetails) {
        let view = FilmDetailsViewController()
        let router = FilmDetailsRouterimpl()
        let interactor = FilmDetailsInteractorimpl(router: router)
        let presenter = FilmDetailsPresenterimpl(
            view: view,
            interactor: interactor,
            filmDetails: film
        )
        view.presenter = presenter
        interactor.presenter = presenter
        presenter.view = view
        router.viewController = view
        
        viewController?.navigationController?.pushViewController(view, animated: true)
    }
}
