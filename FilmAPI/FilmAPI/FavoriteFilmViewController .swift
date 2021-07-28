//
//  FavoriteFilmViewController .swift
//  FilmAPI
//
//  Created by Artem  on 24.07.2021.
//

import UIKit

class FavoriteFilmViewController: UICollectionViewController {
    
    let coreData = DataBaseService(coreDataStack: CoreDataStack())
    
    var films: [Film] = []
    
    let layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: 360, height: 120)
        return layout
    }()
    
    init(){
        super.init(collectionViewLayout: layout)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .clear
        collectionView.collectionViewLayout = layout
        collectionView.register(FilmCellCollectionView.self,
                                forCellWithReuseIdentifier: FilmCellCollectionView.identifier)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        films = coreData.allFilms()
        collectionView.reloadData()
    }
}

extension FavoriteFilmViewController {
    
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

