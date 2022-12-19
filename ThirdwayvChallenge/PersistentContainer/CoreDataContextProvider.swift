//
//  CoreDataContextProvider.swift
//  ThirdwayvChallenge
//
//  Created by Mohamed Shiha on 12/19/22.
//

import CoreData

class CoreDataContextProvider {
	
	/// Current container view context
	var viewContext: NSManagedObjectContext {
		return persistentContainer.viewContext
	}
	
	/// The persistent container
	private var persistentContainer: NSPersistentContainer
	
	init(completionClosure: ((Error?) -> Void)? = nil) {
		// Create a persistent container
		persistentContainer = NSPersistentContainer(name: "Product")
		persistentContainer.loadPersistentStores() { (description, error) in
			if let error = error {
				fatalError("Failed to load Core Data stack: \(error)")
			}
			completionClosure?(error)
		}
	}
	
	/// Creates a context for background work
	func newBackgroundContext() -> NSManagedObjectContext {
		return persistentContainer.newBackgroundContext()
	}
}
