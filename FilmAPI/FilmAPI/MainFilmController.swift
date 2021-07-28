//
//  MainFilmController.swift
//  FilmAPI
//
//  Created by Artem  on 27.07.2021.
//

//import UIKit
//
//class MainFilmController: UIViewController {
//    
//    var films: [FilmDTO] = []
//    
//    let networkService: FilmNetworkServiceProtocol
//    
//    let collectionView = MainFilmCollectionView()
//    
//    init(networkService: FilmNetworkServiceProtocol) {
//        self.networkService = networkService
//        super.init(nibName: nil, bundle: nil)
//        
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        add(collectionView)
//        
//    }
//    
//    
//}
//
//extension MainFilmController: UICollectionViewDelegate {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return films.count
//    }
//    
//    
//}
//
//extension MainFilmController: UICollectionViewDataSource {
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FilmCellCollectionView.identifier, for: indexPath) as? FilmCellCollectionView
//        cell?.setupData(film: films[indexPath.item])
//        return cell ?? UICollectionViewCell()
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let viewController = FilmInfoViewController()
//        viewController.myView.setupData(film: films[indexPath.item])
//            //ImageViewController(networkService: networkService, posterPath: films[indexPath.item].posterPath)
//        present(viewController, animated: true, completion: nil)
//    }
//    
//    
//}
//
//extension MainFilmController {
//    func loadMostPopularFilms() {
//        networkService.getFilm { result in
//            switch result {
//            case .success(let response):
//                self.films = response.results
//                self.loadMostPopularFilmsPosters(films: self.films)
//                DispatchQueue.main.async {
//                    self.collectionView.reloadData()
//                }
//            default: break
//            }
//        }
//    }
//    
//    func loadMostPopularFilmsPosters(films: [FilmDTO]) {
//        for (index, film) in films.enumerated() {
//            networkService.getImage(path: film.posterPath) { data in
//                if let image = UIImage(data: data) {
//                    DispatchQueue.main.async {
//                        self.films[index].poster = image
//                        self.collectionView.reloadData()
//                    }
//                }
//            }
//        }
//    }
//}
//
//extension UIViewController {
//    func add(_ child: UIViewController) {
//        addChild(child)
//        view.addSubview(child.view)
//        child.didMove(toParent: self)
//    }
//    func remove() {
//        // Just to be safe, we check that this view controller
//        // is actually added to a parent before removing it.
//        guard parent != nil else {
//            return
//        }
//        willMove(toParent: nil)
//        view.removeFromSuperview()
//        removeFromParent()
//    }
//}
