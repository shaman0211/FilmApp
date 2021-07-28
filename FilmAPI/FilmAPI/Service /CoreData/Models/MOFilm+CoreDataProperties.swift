//
//  MOFilm+CoreDataProperties.swift
//  FilmAPI
//
//  Created by Artem  on 27.07.2021.
//
//

import Foundation
import CoreData


extension MOFilm {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MOFilm> {
        return NSFetchRequest<MOFilm>(entityName: "MOFilm")
    }

    @NSManaged public var title: String?
    @NSManaged public var posterPath: String?
    @NSManaged public var voteAverage: Double
    @NSManaged public var genreIds: Array<Int>?
    @NSManaged public var id: Int64
    @NSManaged public var releaseDate: String?
    @NSManaged public var overview: String?

}

extension MOFilm : Identifiable {

}
