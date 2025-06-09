//
//  LoginModuleBuilder.swift
//  Kinopoisk
//
//  Created by Евгений Фомичев on 07.06.2025.
//

import UIKit

final class LoginModuleBuilder {
    
    static func build() -> UIViewController {
        let view = LoginViewController()
        let router = LoginRouterimpl()
        let alert = makeAlert()
        let interactor = LoginInteractorimpl(router: router, alalertFactoryert: alert)
        let presenter = LoginPresenterimpl(
            view: view,
            interactor: interactor
        )
        
        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view
        presenter.view = view
        interactor.router = router
        
        return view
    }
}
