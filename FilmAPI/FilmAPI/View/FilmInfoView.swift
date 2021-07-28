//
//  FilmInfoView.swift
//  FilmAPI
//
//  Created by Artem  on 17.07.2021.
//

import UIKit

final class FilmInfoView: UIView {
    
    lazy var gradient: CAGradientLayer = {
        let gradient = CAGradientLayer()

        if let gradientColors = Gradient.allCases.randomElement() {
            gradient.type = .axial
            gradient.colors = gradientColors.colors
            gradient.startPoint = CGPoint(x: 0, y: 0)
            gradient.endPoint = CGPoint(x: 1, y: 1)
        }
        return gradient
    }()
    
//    let navigationBar: UINavigationBar = {
//        let navigationBar = UINavigationBar(frame: .zero)
//        navigationBar.translatesAutoresizingMaskIntoConstraints = false
//        navigationBar.setBackgroundImage(UIImage(), for: .default)
//        navigationBar.shadowImage = UIImage()
//        navigationBar.isTranslucent = true
//        let navItem = UINavigationItem()
//        let doneItem = UIBarButtonItem(systemItem: .save)
//        navItem.rightBarButtonItem = doneItem
//        navigationBar.setItems([navItem], animated: false)
//        return navigationBar
//    }()
//
    private lazy var overviewTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Overview"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 20.0)
        //label.backgroundColor = .red
        return label
    }()
    
    private lazy var releaseDateTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Release Date"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 20.0)
        //label.backgroundColor = .red
        return label
    }()
    
    private lazy var releaseDate: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 20.0)
        //label.backgroundColor = .red
        return label
    }()
    
    private lazy var overview: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 16.0)
        //label.backgroundColor = .red
        return label
    }()
    
    private lazy var poster: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .blue
        imageView.layer.cornerRadius = 35
        imageView.layer.masksToBounds = true
        //imageView.backgroundColor = .red
        return imageView
    }()
    
    private lazy var title: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 20.0)
        label.numberOfLines = 0
        //label.backgroundColor = .red
        return label
    }()
    
    private lazy var genre: UILabel = {
        let label = UILabel()
        label.textColor = .lightText
        label.font = UIFont.boldSystemFont(ofSize: 16.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        //label.backgroundColor = .red
        return label
    }()
    
    private lazy var voteAverage: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 16.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        //label.backgroundColor = .red
        return label
    }()
    
    lazy var saveButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .red
        return button
    }()
    
    func setupData(film: Film) {
        title.text = film.title
        overview.text = film.overview
        voteAverage.text = "⭐️ " + String(film.voteAverage)
        poster.image = film.poster
        genre.text = "Movie"
        releaseDate.text = film.releaseDate
        gradient.colors = Gradient.init(hash: film.title.hash)?.colors
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        setupViews()
    }
    
    override func layoutSubviews() {
        gradient.frame = bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        
        layer.addSublayer(gradient)
        
        let views = [poster, title, genre, voteAverage, overview, overviewTitle, releaseDateTitle, releaseDate, saveButton]
        
        views.forEach {
            addSubview($0)
        }
        
        
        NSLayoutConstraint.activate([
            poster.topAnchor.constraint(equalTo: topAnchor, constant: 64),
            poster.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            poster.widthAnchor.constraint(equalToConstant: 70),
            poster.heightAnchor.constraint(equalToConstant: 70),

            title.topAnchor.constraint(equalTo: poster.topAnchor),
            title.leadingAnchor.constraint(equalTo: poster.trailingAnchor, constant: 10),
            title.widthAnchor.constraint(equalToConstant: 240),

            overviewTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            overviewTitle.topAnchor.constraint(equalTo: poster.bottomAnchor, constant: 20),
            
            overview.topAnchor.constraint(equalTo: overviewTitle.bottomAnchor, constant: 15),
            overview.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            overview.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            voteAverage.topAnchor.constraint(equalTo: overviewTitle.topAnchor),
            voteAverage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            genre.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 3),
            genre.leadingAnchor.constraint(equalTo: title.leadingAnchor),
            
            releaseDateTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            releaseDateTitle.topAnchor.constraint(equalTo: overview.bottomAnchor, constant: 30),
            
            releaseDate.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            releaseDate.topAnchor.constraint(equalTo: releaseDateTitle.bottomAnchor, constant: 10),
            
//            navigationBar.heightAnchor.constraint(equalToConstant: 44),
//            navigationBar.widthAnchor.constraint(equalTo: widthAnchor),
//            navigationBar.centerXAnchor.constraint(equalTo: centerXAnchor)
            saveButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            saveButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            saveButton.heightAnchor.constraint(equalToConstant: 50),
            saveButton.widthAnchor.constraint(equalToConstant: 250),
            saveButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20)
            
        ])
    }
    
    
}
