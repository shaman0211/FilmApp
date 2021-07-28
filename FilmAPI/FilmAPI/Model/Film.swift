//
//  FilmModel.swift
//  FilmAPI
//
//  Created by Artem  on 06.06.2021.
//

import UIKit

struct GetFilmResponse: Decodable {
    let results: [Film]
}

struct Film: Decodable {
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
        self.voteAverage = filmMO.voteAverage ?? 0.0
        self.genreIds = filmMO.genreIds ?? [1]
        self.id = Int(filmMO.id) ?? 0
        self.releaseDate = filmMO.releaseDate ?? "-"
        self.overview = filmMO.overview ?? "-"
    }
    
}




