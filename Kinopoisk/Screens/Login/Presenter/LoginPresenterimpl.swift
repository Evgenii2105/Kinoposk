//
//  LoginPresenterimpl.swift
//  Kinopoisk
//
//  Created by Евгений Фомичев on 07.06.2025.
//

import UIKit

final class LoginPresenterimpl: LoginPresenter {
   
    weak var view: LoginView?
    private let interactor: LoginInteractor
    
    init(view: LoginView, interactor: LoginInteractor) {
        self.view = view
        self.interactor = interactor
    }
    
    func hadleAuth(login: String?, password: String?) {
        interactor.hadleAuth(login: login, password: password)
    }
}

extension LoginPresenterimpl: LoginPresenterOutput {

}
