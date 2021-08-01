//
//  FilmModel.swift
//  FilmAPI
//
//  Created by Artem  on 06.06.2021.
//

import UIKit

struct GetFilmResponse: Decodable {
    let results: [Film]
    
    init(results: [Film]) {
        self.results = results
    }
}

struct Film: Decodable, Equatable {
    var title: String
    var posterPath: String
    var voteAverage: Double
    var genreIds: [Int]
    var poster: UIImage?
    var id: Int
    let releaseDate: String
    let overview: String
    
    enum CodingKeys: String, CodingKey {
        case title
        case posterPath
        case voteAverage
        case genreIds
        case id
        case releaseDate
        case overview
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        title = try container.decode(String.self, forKey: .title)
        posterPath = try container.decode(String.self, forKey: .posterPath)
        voteAverage = try container.decode(Double.self, forKey: .voteAverage)
        genreIds = try container.decode([Int].self, forKey: .genreIds)
        id = try container.decode(Int.self, forKey: .id)
        releaseDate = try container.decode(String.self, forKey: .releaseDate)
        overview = try container.decode(String.self, forKey: .overview)
    }
    
    init(with filmMO: MOFilm) {
        self.title = filmMO.title ?? "-"
        self.posterPath = filmMO.posterPath ?? "-"
        self.voteAverage = filmMO.voteAverage
        self.genreIds = filmMO.genreIds ?? [1]
        self.id = Int(filmMO.id)
        self.releaseDate = filmMO.releaseDate ?? "-"
        self.overview = filmMO.overview ?? "-"
    }
    
    init(title: String) {
        self.title = title
        posterPath = " "
        voteAverage = 0.0
        genreIds = [0]
        id = 0
        releaseDate = " "
        overview = " "
    }
    
}




