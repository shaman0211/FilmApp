//
//  DataBaseService.swift
//  FilmAPI
//
//  Created by Artem  on 27.07.2021.
//

import CoreData

protocol DataBaseProtocol {
    
}

final class DataBaseService {
    
    private let stack: CoreDataStack

    init(coreDataStack: CoreDataStack) {
        stack = coreDataStack
    }
    
    func writeFilm(with filmDTO: Film) {
        let backgroundContext = stack.mainContext
        backgroundContext.performAndWait{
            let checkFilm = try? fetchRequestForFilm(for: filmDTO).execute()
            if checkFilm?.isEmpty ?? false {
                //запись только в беке чтение в мейне
                let film = MOFilm(context: backgroundContext, with: filmDTO)
                
            }
            try? backgroundContext.save()
        }
        
    }
    
    func allFilms() -> [Film] {
        let context = stack.mainContext
        var result = [Film]()
        
        let request = NSFetchRequest<MOFilm>(entityName: "MOFilm")
        context.performAndWait {
            guard let films = try? request.execute() else { return }
            result = films.map { Film(with: $0) }
        }
        return result
    }
    
    func readFilm(with predicate: NSPredicate) -> [Film] {
        let context = stack.mainContext
        var result = [Film]()
        
        let request = NSFetchRequest<MOFilm>(entityName: "MOFilm")
        request.predicate = predicate
        context.performAndWait {
            guard let films = try? request.execute() else { return }
            result = films.map { Film(with: $0) }
        }
        return result
    }
    
    func deleteFilm(with film: Film) {
        let context = stack.backgroundContext
        context.performAndWait {
            if let deleteFilm = try? self.fetchRequestForFilm(for: film).execute().first {
                context.delete(deleteFilm)
            }
            try? context.save()
        }
    }
    
    func deleteAll() {
        let fetchRequest = NSFetchRequest<MOFilm>(entityName: "MOFilm")
        let context = stack.backgroundContext
        context.performAndWait {
            let films = try? fetchRequest.execute()
            films?.forEach {
                context.delete($0)
            }
            try? context.save()
        }

    }

}

private extension DataBaseService {
    private func fetchRequestForFilm(for dto: Film) -> NSFetchRequest<MOFilm> {
        let request = NSFetchRequest<MOFilm>(entityName: "MOFilm")
        request.predicate = .init(format: "id == %@", NSNumber(value: dto.id))
        return request
    }
}
