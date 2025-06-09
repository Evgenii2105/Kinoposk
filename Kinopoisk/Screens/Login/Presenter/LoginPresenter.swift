//
//  LoginPresenter.swift
//  Kinopoisk
//
//  Created by Евгений Фомичев on 07.06.2025.
//

import Foundation

protocol LoginPresenter: AnyObject {
    func hadleAuth(login: String?, password: String?)
}

protocol LoginPresenterOutput: AnyObject {
}
