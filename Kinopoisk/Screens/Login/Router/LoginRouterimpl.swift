//
//  LoginRouterimpl.swift
//  Kinopoisk
//
//  Created by Евгений Фомичев on 07.06.2025.
//

import UIKit

final class LoginRouterimpl: LoginRouter {
  
    weak var viewController: UIViewController?
    
    func openFilmsListViewController() {
        let view = FilmsListViewController()
        
        let router = FilmsListRouterimpl()
        let interactor = FilmsListInteractorimpl(
            router: router
        )
        let presenter = FilmsListPresenterimpl(
            view: view,
            interactor: interactor
        )
        view.presenter = presenter
        presenter.view = view
        interactor.presenter = presenter
        router.viewController = view
        
        viewController?.navigationController?.pushViewController(
            view,
            animated: true
        )
    }
    
    func showAlert(alert: AlertContentPresentable) {
        viewController?.present(alert.alert, animated: alert.isAnimated)
    }
}
