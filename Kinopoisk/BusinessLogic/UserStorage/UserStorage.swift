//
//  Untitled.swift
//  Kinopoisk
//
//  Created by Евгений Фомичев on 07.06.2025.
//

import Foundation

final class UserStorageimpl {
    
    enum ValidationState {
        case success
        case userNotFound
        case wrongPassword
    }
    
    private let userDefaults = UserDefaults.standard
    
    func saveLoginAndPassword(login: String, password: String) {
        userDefaults.set(password, forKey: login)
        userDefaults.synchronize()
    }
    
    func validateUserPassword(login: String, password: String) -> ValidationState {
        guard let passwordToCheck = userDefaults.string(forKey: login) else { return .userNotFound }
        
        if passwordToCheck == password {
            return .success
        } else {
            return .wrongPassword
        }
    }
}
