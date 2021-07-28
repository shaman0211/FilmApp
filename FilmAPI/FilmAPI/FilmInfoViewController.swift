//
//  File.swift
//  FilmAPI
//
//  Created by Artem  on 17.07.2021.
//

import UIKit

final class FilmInfoViewController: UIViewController {
    
    let coreData = DataBaseService(coreDataStack: CoreDataStack())
    
    let filmView: FilmInfoView = {
        let view = FilmInfoView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(filmView)
        setupView()
        view.backgroundColor = .white
        filmView.saveButton.addTarget(self, action: #selector(buttonTap), for: .touchUpInside)
    }
    
    func setupView() {
        view.addSubview(filmView)
        
        NSLayoutConstraint.activate([
            filmView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            filmView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            filmView.heightAnchor.constraint(equalTo: view.heightAnchor),
            filmView.widthAnchor.constraint(equalTo: view.widthAnchor),
        ])
    }
    
    @objc func buttonTap() {
        //coreData.writeFilm(with: )
    }
    
}


