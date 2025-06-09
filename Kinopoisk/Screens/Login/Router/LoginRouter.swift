//
//  LoginRouter.swift
//  Kinopoisk
//
//  Created by Евгений Фомичев on 07.06.2025.
//

import Foundation

protocol LoginRouter: AnyObject {
    func openFilmsListViewController()
    func showAlert(alert: AlertContentPresentable)
}
