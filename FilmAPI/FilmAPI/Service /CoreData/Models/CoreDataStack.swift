//
//  CoreDataStack.swift
//  FilmAPI
//
//  Created by Artem  on 27.07.2021.
//

import CoreData

final class CoreDataStack {

    let mainContext: NSManagedObjectContext
    let backgroundContext: NSManagedObjectContext

    private let objectModel: NSManagedObjectModel = {
        guard let url = Bundle.main.url(forResource: "FilmAPI", withExtension: "momd") else {
            fatalError("CoreData MOMD is nil")
        }
        guard let model = NSManagedObjectModel(contentsOf: url) else {
            fatalError("CoreData MOMD is nil")
        }
        return model
    }()

    private let coordinator: NSPersistentStoreCoordinator

    init() {

        guard let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first else {
            fatalError("Documents is nil")
        }
        let url = URL(fileURLWithPath: documentsPath).appendingPathComponent("FilmAPI.sqlite")
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: objectModel)

        do {
            try coordinator.addPersistentStore(ofType: NSSQLiteStoreType,
                                              configurationName: nil,
                                              at: url,
                                              options: [NSMigratePersistentStoresAutomaticallyOption: true,
                                                        NSInferMappingModelAutomaticallyOption: true])
        } catch {
            fatalError()
        }

        self.coordinator = coordinator
        self.mainContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        self.mainContext.persistentStoreCoordinator = coordinator

        self.backgroundContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        self.backgroundContext.persistentStoreCoordinator = coordinator

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(contextDidChange(notification:)),
                                               name: Notification.Name.NSManagedObjectContextDidSave,
                                               object: self.backgroundContext)
    }


    func deleteAll() {
        let fetchRequest = NSFetchRequest<MOFilm>(entityName: "MOFilm")
        backgroundContext.performAndWait {
            let cards = try? fetchRequest.execute()
            cards?.forEach {
                backgroundContext.delete($0)
            }
            try? backgroundContext.save()
        }

    }
}

private extension CoreDataStack {
    @objc func contextDidChange(notification: Notification) {
        coordinator.performAndWait {
            mainContext.performAndWait {
                mainContext.mergeChanges(fromContextDidSave: notification)
            }
        }
    }
}


