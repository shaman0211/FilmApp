//
//  MainAssembly.swift
//  FilmAPI
//
//  Created by Artem  on 18.07.2021.
//

import UIKit

final class MainAssembly {

    func createMainScreen() -> UIViewController {
        let tabBarController = UITabBarController()
        
        tabBarController.viewControllers = [
            createViewController(controller: MainFilmCollectionView(networkService: FilmNetworkService()),
                                 title: "Popular Films",
                                 image: UIImage(systemName: "pencil")),
            createViewController(controller: SearchFilmViewController(networkService: FilmNetworkService()),
                                 title: "Search",
                                 image: UIImage(systemName: "cloud")),
            createViewController(controller: FavoriteFilmViewController(),
                                 title: "Favorite Films",
                                 image: UIImage(systemName: "cloud"))
        ]
        return tabBarController
    }

}

private extension MainAssembly {
    
    func createViewController(controller: UIViewController, title: String, image: UIImage?) -> UINavigationController {
        let navigationController = UINavigationController(rootViewController: controller)
        controller.title = title
        controller.modalPresentationStyle = .fullScreen
        navigationController.navigationBar.prefersLargeTitles = true
        navigationController.tabBarItem = UITabBarItem(title: title, image: image, selectedImage: nil)
        navigationController.view.backgroundColor = .white
        return navigationController
    }

}
