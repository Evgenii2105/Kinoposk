//
//  FilmsListViewController.swift
//  Kinopoisk
//
//  Created by Евгений Фомичев on 07.06.2025.
//

import UIKit

final class FilmsListViewController: UIViewController {
    
    var presenter: FilmsListPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
    }
}

extension FilmsListViewController: FilmsListView {
    
}
