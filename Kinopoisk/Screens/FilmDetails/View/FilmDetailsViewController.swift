//
//  FilmDetailsViewController.swift
//  Kinopoisk
//
//  Created by Евгений Фомичев on 07.06.2025.
//

import UIKit

final class FilmDetailsViewController: UIViewController {
    
    var presenter: FilmDetailsPresenter?
    private var cellTypes: [FilmDetailCellType] = []
    
    private let filmDetailsTable: UITableView = {
        let filmDetailsTable = UITableView()
        filmDetailsTable.backgroundColor = .black
        return filmDetailsTable
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        configureMovieDescriptionTable()
        presenter?.setupDataSource()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        filmDetailsTable.frame = view.bounds
        filmDetailsTable.contentInset.bottom = view.safeAreaInsets.bottom
    }
    
    private func setupUI() {
        view.backgroundColor = .black
        view.addSubview(filmDetailsTable)
        navigationController?.navigationBar.barTintColor = .black
        navigationController?.navigationBar.isTranslucent = false
    }
    
    private func setupConstraints() {
        filmDetailsTable.addConstraints(constraints: [
            filmDetailsTable.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            filmDetailsTable.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            filmDetailsTable.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            filmDetailsTable.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func configureMovieDescriptionTable() {
        filmDetailsTable.delegate = self
        filmDetailsTable.dataSource = self
        filmDetailsTable.register(ImageDetailCell.self, forCellReuseIdentifier: ImageDetailCell.cellidentifire)
        filmDetailsTable.register(DetailsFilmTableViewCell.self, forCellReuseIdentifier: DetailsFilmTableViewCell.cellidintifire)
        filmDetailsTable.register(GenreYearTableViewCell.self, forCellReuseIdentifier: GenreYearTableViewCell.cellidintifire)
        filmDetailsTable.register(PicturesTableViewCell.self, forCellReuseIdentifier: PicturesTableViewCell.cellidintifire)
        filmDetailsTable.register(RecommendationsFilmsTableViewCell.self, forCellReuseIdentifier: RecommendationsFilmsTableViewCell.cellidintifire)
        filmDetailsTable.separatorStyle = .none
    }
}

extension FilmDetailsViewController: FilmDetailsView {
    
    func showFilmDetails(cellTypes: [FilmDetailCellType]) {
        self.cellTypes = cellTypes.filter({ cellTypes in
            switch cellTypes {
            case .pictures(let imageNames):
                return !imageNames.isEmpty
            case .similarMovies(let films):
                return !films.isEmpty
            default:
                return true
            }
        })
        filmDetailsTable.reloadData()
    }
}

extension FilmDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellTypes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellTypes = cellTypes[indexPath.row]
        
        switch cellTypes {
            
        case .movieHeaderPicture(let imageURL, let name, let rating):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ImageDetailCell.cellidentifire, for: indexPath) as? ImageDetailCell else {
                return UITableViewCell()
            }
            
            cell.configure(name: name, imageURL: imageURL, rating: rating)
            return cell
            
        case .description(let link, let description):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailsFilmTableViewCell.cellidintifire, for: indexPath) as? DetailsFilmTableViewCell else {
                return UITableViewCell()
            }

            cell.configure(description: description, link: link)
            return cell
            
        case .genreAndYear(let genres, let startYear, let endYear, let country, let year):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: GenreYearTableViewCell.cellidintifire, for: indexPath) as? GenreYearTableViewCell else {
                return UITableViewCell()
            }
            cell.configure(genres: genres, countries: country, startYear: startYear, endYear: endYear, year: year)
            return cell
            
        case .pictures(let imagesNames):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PicturesTableViewCell.cellidintifire, for: indexPath) as? PicturesTableViewCell else {
                return UITableViewCell()
            }
            cell.configure(with: imagesNames)
            return cell
        case .similarMovies(films: let films):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: RecommendationsFilmsTableViewCell.cellidintifire, for: indexPath) as? RecommendationsFilmsTableViewCell else { return UITableViewCell() }
            cell.delegate = self
            cell.configure(films: films)
            return cell
        }
    }
}

extension FilmDetailsViewController: RecommendationsFilmsTableViewCellDelegate {
    
    func tappedSimilar(filmId: Int) {
        presenter?.makeFilmsSimilarFilms(filmId: filmId)
    }
}
