//
//  Gradient.swift
//  FilmAPI
//
//  Created by Artem  on 26.07.2021.
//

import UIKit

enum Gradient: Int, CaseIterable {
    case sunOnTheHorizon = 0
    case darkOcean
    case telegram
    case peach
    case cinnamint
    
    var colors: [CGColor] {
        switch self {
        case .sunOnTheHorizon:
            return [UIColor(red: 0.97, green: 0.71, blue: 0.00, alpha: 1.00).cgColor,
                    UIColor(red: 0.99, green: 0.92, blue: 0.73, alpha: 1.00).cgColor]
        case .darkOcean:
            return [UIColor(red: 0.22, green: 0.23, blue: 0.27, alpha: 1.00).cgColor,
                    UIColor(red: 0.26, green: 0.53, blue: 0.96, alpha: 1.00).cgColor]
        case .telegram:
            return [UIColor(red: 0.11, green: 0.57, blue: 0.82, alpha: 1.00).cgColor,
                    UIColor(red: 0.95, green: 0.99, blue: 1.00, alpha: 1.00).cgColor]
        case .peach:
            return [UIColor(red: 0.93, green: 0.26, blue: 0.39, alpha: 1.00).cgColor,
                    UIColor(red: 1.00, green: 0.93, blue: 0.74, alpha: 1.00).cgColor]
        case .cinnamint:
            return [UIColor(red: 0.29, green: 0.76, blue: 0.60, alpha: 1.00).cgColor,
                    UIColor(red: 0.74, green: 1.00, blue: 0.95, alpha: 1.00).cgColor]
        }
        
    }
    init?(hash: Int) {
        let modulo = abs(hash) % Gradient.allCases.count
        self = Gradient(rawValue: modulo)!
    }
}

let genres = [28: "Action",
              12: "Adventure",
              16: "Animation",
              35: "Comedy",
              80: "Crime",
              99: "Documentary",
              18: "Drama",
              10751: "Family",
              14: "Fantasy",
              36: "History",
              27: "Horror",
              10402: "Music",
              9648: "Mystery",
              10749: "Romance",
              878: "Science Fiction",
              10770: "TV Movie",
              53: "Thriller",
              10752: "War",
              37: "Western"]
