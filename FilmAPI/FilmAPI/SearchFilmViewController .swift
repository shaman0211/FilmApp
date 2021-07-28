//
//  SearchFilmViewController .swift
//  FilmAPI
//
//  Created by Artem  on 18.07.2021.
//

import UIKit

class SearchFilmViewController: UICollectionViewController {
    
    var films: [Film] = []
    
    
    
    let networkService: FilmNetworkServiceProtocol
    lazy var searchController = UISearchController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        collectionView.collectionViewLayout = layout
        collectionView.register(FilmCellCollectionView.self,
                                forCellWithReuseIdentifier: FilmCellCollectionView.identifier)
        setupNavigationBar()
    }
    
    
    let layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: 360, height: 120)
        return layout
    }()
    
    
    
    init(networkService: FilmNetworkServiceProtocol) {
        self.networkService = networkService
        super.init(collectionViewLayout: layout)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension SearchFilmViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(execute(_:)), object: searchBar)
        perform(#selector(execute(_:)), with: searchBar, afterDelay: 0.25)
    }

}

private extension SearchFilmViewController {
    
    func setupNavigationBar() {
        navigationItem.searchController = searchController
        searchController.searchBar.delegate = self
    }
    
    @objc func execute(_ searchBar: UISearchBar) {
        guard let query = searchBar.text, query.trimmingCharacters(in: .whitespaces) != "" else {
            print("nothing to search")
            return
        }
        networkService.searchFilm(query: query) { result in
            switch result {
            case .success(let response):
                self.films = response.results
                self.loadMostPopularFilmsPosters(films: self.films)
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            default: break
            }
        }
    }
    
    func loadMostPopularFilmsPosters(films: [Film]) {
        for (index, film) in films.enumerated() {
            networkService.getImage(path: film.posterPath) { data in
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.films[index].poster = image
                        self.collectionView.reloadData()
                    }
                }
            }
        }
    }
}

extension SearchFilmViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return films.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FilmCellCollectionView.identifier, for: indexPath) as? FilmCellCollectionView
        cell?.setupData(film: films[indexPath.item])
        return cell ?? UICollectionViewCell()
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let viewController = FilmInfoViewController()
        viewController.filmView.setupData(film: films[indexPath.item])
            //ImageViewController(networkService: networkService, posterPath: films[indexPath.item].posterPath)
        present(viewController, animated: true, completion: nil)
    }
}
