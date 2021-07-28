//
//  FilmCellCollectionView.swift
//  FilmAPI
//
//  Created by Artem  on 15.07.2021.
//

import UIKit

class FilmCellCollectionView: UICollectionViewCell {
    
    static let identifier = "FilmCell"
    
    var saveButtonTapDelegate: (() -> Void)?
    
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
    
    private lazy var poster: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .blue
        imageView.layer.cornerRadius = 5
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private lazy var title: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 20.0)
        label.numberOfLines = 2
        return label
    }()
    
    private lazy var genre: UILabel = {
        let label = UILabel()
        label.textColor = .lightText
        label.font = UIFont.boldSystemFont(ofSize: 16.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var voteAverage: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 16.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var saveButton: UIButton = {
        let button = UIButton()
        button.contentMode = .center
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(saveButtonTap), for: .touchUpInside)
        return button
    }()
    
    @objc
    func saveButtonTap() {
        saveButtonTapDelegate?()
    }
    
    func setupData(film: Film) {
        title.text = film.title
        voteAverage.text = "⭐️ " + String(film.voteAverage)
        poster.image = film.poster
        genre.text = "Movie"
        gradient.colors = Gradient.init(hash: film.title.hash)?.colors
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        setupViews()
        layer.cornerRadius = 22
        layer.masksToBounds = true
        
    }
    
    override func layoutSubviews() {
        gradient.frame = bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        
        layer.addSublayer(gradient)
        
        let views = [poster, title, genre, voteAverage, saveButton]
        
        views.forEach {
            addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            poster.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            poster.widthAnchor.constraint(equalToConstant: 60),
            poster.heightAnchor.constraint(equalToConstant: 80),
            poster.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            
            title.topAnchor.constraint(equalTo: poster.topAnchor),
            title.leadingAnchor.constraint(equalTo: poster.trailingAnchor, constant: 10),
            title.widthAnchor.constraint(equalToConstant: 240),
            
            genre.leadingAnchor.constraint(equalTo: poster.trailingAnchor, constant: 10),
            genre.bottomAnchor.constraint(equalTo: poster.bottomAnchor, constant: -3),
            
            voteAverage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            voteAverage.bottomAnchor.constraint(equalTo: genre.bottomAnchor),
            
            saveButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            saveButton.topAnchor.constraint(equalTo: poster.topAnchor)
        
        ])
    }
}

//
//"backdrop_sizes": [
//      "w45",
//      "w92",
//      "w154",
//      "w185",
//      "w300",
//      "w500",
//      "w780",
//      "w1280",
//      "w1920",
//      "original"
//    ],
//    "logo_sizes": [
//      "w45",
//      "w92",
//      "w154",
//      "w185",
//      "w300",
//      "w500",
//      "original"
//    ],
//    "poster_sizes": [
//      "w45",
//      "w92",
//      "w154",
//      "w185",
//      "w300",
//      "w342",
//      "w500",
//      "w780",
//      "original"
//    ],
//    "profile_sizes": [
//      "w45",
//      "w92",
//      "w154",
//      "w185",
//      "h632",
//      "original"
//    ],
//    "still_sizes": [
//      "w45",
//      "w92",
//      "w154",
//      "w185",
//      "w300",
//      "original"
//    ]

