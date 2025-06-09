//
//  LoginInteractorimpl.swift
//  Kinopoisk
//
//  Created by Евгений Фомичев on 07.06.2025.
//

import UIKit

final class LoginInteractorimpl: LoginInteractor {
   
    weak var presenter: LoginPresenterOutput?
    var router: LoginRouter
    var userStorage = UserStorageimpl()
    var alertFactory: AlertFactoryService
    
    init(router: LoginRouter, alalertFactoryert: AlertFactoryService) {
        self.router = router
        self.alertFactory = alalertFactoryert
    }
    
    func hadleAuth(login: String?, password: String?)  {
        guard let login, !login.isEmpty,
              let password, !password.isEmpty else {
            let alert = alertFactory.failureLoginIsEmpty(message: "Введите логин и пароль")
            router.showAlert(alert: alert)
            return
        }
        
        switch userStorage.validateUserPassword(login: login, password: password) {
        case .success:
            router.openFilmsListViewController()
        case .userNotFound:
            userStorage.saveLoginAndPassword(login: login, password: password)
            router.openFilmsListViewController()
        case .wrongPassword:
            let alert = alertFactory.failurePassword(message: "Введите правильный пароль")
            router.showAlert(alert: alert)
        }
    }
}
