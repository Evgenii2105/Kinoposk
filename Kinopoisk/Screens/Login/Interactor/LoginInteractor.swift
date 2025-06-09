//
//  LoginInteractor.swift
//  Kinopoisk
//
//  Created by Евгений Фомичев on 07.06.2025.
//

import UIKit

protocol LoginInteractor: AnyObject {
    func hadleAuth(login: String?, password: String?)
}
