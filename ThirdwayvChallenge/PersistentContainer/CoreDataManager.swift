//
//  CoreDataManager.swift
//  ThirdwayvChallenge
//
//  Created by Mohamed Shiha on 12/19/22.
//

import Foundation
import CoreData

final class CoreDataManager {
	
	// MARK: - Properties
	
	private let modelName: String
	
	/// managedObjectContext manages a collection of managed objects.
	private(set) lazy var managedObjectContext: NSManagedObjectContext = {
		let managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
		managedObjectContext.persistentStoreCoordinator = self.persistentStoreCoordinator
		return managedObjectContext
	}()
	
	/// The schema used by Core Data model.
	private lazy var managedObjectModel: NSManagedObjectModel = {
		guard let modelURL = Bundle.main.url(forResource: self.modelName, withExtension: "momd") else {
			fatalError("Unable to Find Data Model")
		}
		
		guard let managedObjectModel = NSManagedObjectModel(contentsOf: modelURL) else {
			fatalError("Unable to Load Data Model")
		}

		return managedObjectModel
	}()
	
	/// The coordinater between the data model and the application interface.
	private lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
		
		let persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
		
		// Finding the database file
		let fileManager = FileManager.default
		let storeName = "\(self.modelName).sqlite"
		let documentsDirectoryURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
		
		let persistentStoreURL = documentsDirectoryURL.appendingPathComponent(storeName)
		
		do {
			try persistentStoreCoordinator.addPersistentStore(ofType: NSSQLiteStoreType,
															  configurationName: nil,
															  at: persistentStoreURL,
															  options: nil)
		} catch {
			fatalError("Unable to Load Persistent Store")
		}
		
		return persistentStoreCoordinator
	}()

	
	// MARK: - Initializers
	
	init(modelName: String) {
		self.modelName = modelName
	}
}
