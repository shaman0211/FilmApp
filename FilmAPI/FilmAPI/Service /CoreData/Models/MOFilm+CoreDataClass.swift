//
//  MOFilm+CoreDataClass.swift
//  FilmAPI
//
//  Created by Artem  on 27.07.2021.
//
//

import Foundation
import CoreData

@objc(MOFilm)
public class MOFilm: NSManagedObject {
    
    convenience init(context: NSManagedObjectContext, with filmDTO: Film) {
        self.init(context: context)
        self.title = filmDTO.title
        self.posterPath = filmDTO.posterPath
        self.voteAverage = filmDTO.voteAverage
        self.genreIds = filmDTO.genreIds
        self.id = Int64(filmDTO.id)
        self.releaseDate = filmDTO.releaseDate
        self.overview = filmDTO.overview
    }
    
}
