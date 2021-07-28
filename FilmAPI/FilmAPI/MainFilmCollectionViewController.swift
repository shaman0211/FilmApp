//
//  MainFilmCollectionView .swift
//  FilmAPI
//
//  Created by Artem  on 15.07.2021.
//

import UIKit

class MainFilmCollectionView: UICollectionViewController {
    
    var films: [Film] = []
    
    let networkService: FilmNetworkServiceProtocol
    
    let layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: 360, height: 120)
        return layout
    }()
    
    init(networkService: FilmNetworkServiceProtocol){
        self.networkService = networkService
        super.init(collectionViewLayout: layout)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let coreData = DataBaseService(coreDataStack: CoreDataStack())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .clear
        collectionView.collectionViewLayout = layout
        collectionView.register(FilmCellCollectionView.self,
                                forCellWithReuseIdentifier: FilmCellCollectionView.identifier)
        loadMostPopularFilms()
        
    }
    
}

extension MainFilmCollectionView {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return films.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FilmCellCollectionView.identifier, for: indexPath) as? FilmCellCollectionView
        cell?.setupData(film: films[indexPath.item])
        cell?.saveButtonTapDelegate = {
            self.coreData.writeFilm(with: self.films[indexPath.item])
            print(self.coreData.allFilms().count)
        }
        return cell ?? UICollectionViewCell()
        
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let viewController = FilmInfoViewController()
        viewController.filmView.setupData(film: films[indexPath.item])
        //coreData.writeFilm(with: films[indexPath.item])
        //ImageViewController(networkService: networkService, posterPath: films[indexPath.item].posterPath)
        present(viewController, animated: true, completion: nil)
    }
    
    
}

private extension MainFilmCollectionView {
    
    func loadMostPopularFilms() {
        networkService.getFilm { result in
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
