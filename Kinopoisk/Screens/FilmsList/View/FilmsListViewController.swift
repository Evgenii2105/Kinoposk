//
//  FilmsListViewController.swift
//  Kinopoisk
//
//  Created by Евгений Фомичев on 07.06.2025.
//

import UIKit

final class FilmsListViewController: UIViewController {
    
    enum FilmSorting {
        case sortedDefault
        case sortedDescending
        case sortedAscending
    }
    
    var presenter: FilmsListPresenter?
    private var films: [FilmsListItem] = []
    private var currentSorted: FilmSorting = .sortedDefault
    
    private lazy var exitButton: UIBarButtonItem = {
        let image = UIImage(systemName: "rectangle.portrait.and.arrow.right")?.withConfiguration(UIImage.SymbolConfiguration(weight: .bold))
        let exitButton = UIBarButtonItem(
            image: image,
            style: .plain,
            target: self,
            action: #selector(tappedExit)
        )
        exitButton.tintColor = .cyan
        return exitButton
    }()
    
    private lazy var searchTextField: UITextField = {
        let searchTextField = UITextField()
        searchTextField.attributedPlaceholder = NSAttributedString(
            string: "Поиск фильмов",
            attributes: [.foregroundColor: UIColor.lightGray]
        )
        searchTextField.borderStyle = .roundedRect
        searchTextField.layer.borderColor = UIColor.lightGray.cgColor
        searchTextField.layer.cornerRadius = 8
        searchTextField.layer.borderWidth = 1
        searchTextField.backgroundColor = .black
        searchTextField.textColor = .white
        
        let searchButton = UIButton(type: .custom)
        let searchImage = UIImage(systemName: "magnifyingglass")
        searchButton.setImage(searchImage, for: .normal)
        searchButton.tintColor = .cyan
        searchButton.frame = CGRect(x: 0, y: 0, width: 40, height: 30)
        searchButton.addAction(
            UIAction { [weak self] _ in
                self?.tappedSearchButton()
            },
            for: .touchUpInside)
        
        let buttonContainer = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 30))
        buttonContainer.addSubview(searchButton)
        searchTextField.rightView = buttonContainer
        searchTextField.rightViewMode = .always
        
        return searchTextField
    }()
    
    private lazy var yearButton: UIButton = {
        var config = UIButton.Configuration.plain()
        config.title = "Фильмы по годам"
        config.image = UIImage(systemName: "chevron.down")?.withTintColor(.cyan, renderingMode: .alwaysOriginal)
        config.imagePlacement = .trailing
        config.imagePadding = 8
        config.baseBackgroundColor = .white
        
        let yearButton = UIButton(configuration: config)
        yearButton.backgroundColor = .black
        yearButton.layer.borderWidth = 1
        yearButton.layer.cornerRadius = 8
        yearButton.layer.borderColor = UIColor.lightGray.cgColor
        yearButton.addTarget(self, action: #selector(toggleYearPicker), for: .touchUpInside)
        return yearButton
    }()
    
    private lazy var sortedButton: UIButton = {
        let sortedButton = UIButton()
        let image = UIImage(systemName: "arrow.up.arrow.down")
        sortedButton.setImage(image, for: .normal)
        sortedButton.tintColor = .cyan
        sortedButton.addAction(
            UIAction(
                handler: { [weak self] _ in
                    self?.tapSortedButton()
                }), for: .touchUpInside)
        return sortedButton
    }()
    
    private let filmsTable: UITableView = {
        let filmsTable = UITableView()
        filmsTable.backgroundColor = .black
        return filmsTable
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        setupDelegateTextField()
        createListFilmsTable()
        presenter?.setupDataSource()
        setupNavigationBar()
    }
    
    private func setupUI() {
        view.backgroundColor = .black
        view.addSubview(searchTextField)
        view.addSubview(yearButton)
        view.addSubview(sortedButton)
        view.addSubview(filmsTable)
        navigationItem.hidesBackButton = true
    }
    
    private func setupConstraints() {
        searchTextField.addConstraints(constraints: [
            searchTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            searchTextField.leadingAnchor.constraint(equalTo: sortedButton.trailingAnchor, constant: 8),
            searchTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            searchTextField.heightAnchor.constraint(equalToConstant: 44)
        ])
        yearButton.addConstraints(constraints: [
            yearButton.topAnchor.constraint(equalTo: searchTextField.bottomAnchor, constant: 8),
            yearButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            yearButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            yearButton.heightAnchor.constraint(equalToConstant: 44)
        ])
        sortedButton.addConstraints(constraints: [
            sortedButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            sortedButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            sortedButton.trailingAnchor.constraint(equalTo: searchTextField.leadingAnchor, constant: -8),
            sortedButton.bottomAnchor.constraint(equalTo: yearButton.topAnchor, constant: -8),
            sortedButton.heightAnchor.constraint(equalToConstant: 44),
            sortedButton.widthAnchor.constraint(equalToConstant: 44)
        ])
        filmsTable.addConstraints(constraints: [
            filmsTable.topAnchor.constraint(equalTo: yearButton.bottomAnchor, constant: 8),
            filmsTable.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            filmsTable.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            filmsTable.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func setupDelegateTextField() {
        searchTextField.delegate = self
    }
    
    private func setupNavigationBar() {
        let titleLabel = UILabel()
        titleLabel.text = "Кинопоиск"
        titleLabel.font = .systemFont(ofSize: 26, weight: .bold)
        titleLabel.textColor = .cyan
        titleLabel.sizeToFit()
        
        navigationItem.titleView = titleLabel
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.rightBarButtonItem = exitButton
    }
    
    private func createListFilmsTable() {
        filmsTable.register(FilmsListCell.self, forCellReuseIdentifier: FilmsListCell.cellidentifire)
        filmsTable.delegate = self
        filmsTable.dataSource = self
    }
    
    @objc
    private func tappedExit() {
        view.endEditing(true)
        presenter?.performLogaut()
    }
    
    @objc
    private func tappedSearchButton() {
        presenter?.searchFilms(with: searchTextField.text)
    }
    
    @objc
    private func tapSortedButton() {
        sortedButton.showsMenuAsPrimaryAction = true
        
        let sortedDefault = UIAction(
            title: "Сортировка по уолчанию",
            state: currentSorted == .sortedDefault ? .on : .off,
            handler: { [weak self] _ in
                self?.currentSorted = .sortedDefault
                self?.tapSortedButton()
                self?.presenter?.sort(by: .sortedDefault)
            })
        
        let sortedDescending = UIAction(
            title: "Сортировка по убыванию рейтинга",
            state: currentSorted == .sortedDescending ? .on : .off,
            handler: { [weak self] _ in
                self?.currentSorted = .sortedDescending
                self?.tapSortedButton()
                self?.presenter?.sort(by: .sortedDescending)
            })
        
        let sortedAscending = UIAction(
            title: "Сортировка по возрастанию рейтинга",
            state: currentSorted == .sortedAscending ? .on : .off,
            handler: { [weak self] _ in
                self?.currentSorted = .sortedAscending
                self?.tapSortedButton()
                self?.presenter?.sort(by: .sortedAscending)
            })
        sortedButton.menu = UIMenu(title: "", children: [sortedDefault, sortedDescending, sortedAscending])
    }
    
    @objc
    private func toggleYearPicker() {
        var years: [GenericPickerViewController.YearFilter] = [.allYears]
        let array = Array(1990...2025).map({ GenericPickerViewController.YearFilter.specificYear($0) })
        years.append(contentsOf: array)
        
        let pickerVC = GenericPickerViewController.makePickerController(with: years)
        if let navVC = pickerVC as? UINavigationController,
           let yearPickerVC = navVC.topViewController as? GenericPickerViewController {
            yearPickerVC.delegate = self
        }
        present(pickerVC, animated: true)
    }
}

extension FilmsListViewController: FilmsListView {
    func didFilms(films: [FilmsListItem]) {
        self.films = films
        filmsTable.reloadData()
    }
}

extension FilmsListViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == searchTextField {
            searchTextField.resignFirstResponder()
        }
        return true
    }
}

extension FilmsListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        films.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FilmsListCell.cellidentifire, for: indexPath) as? FilmsListCell, indexPath.row < films.count else {
            return UITableViewCell()
        }
        
        let film = films[indexPath.row]
        cell.configure(with: film)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return  150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter?.showDetailsFilm(film: films[indexPath.row])
    }
}

extension FilmsListViewController: CustomPickerDelegate {
    
    func didSelectYear(year: GenericPickerViewController.YearFilter) {
        yearButton.setTitle(year.stringValue, for: .normal)
        presenter?.filter(by: year)
    }
}
