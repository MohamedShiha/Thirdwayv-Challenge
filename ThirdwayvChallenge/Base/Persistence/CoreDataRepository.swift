//
//  CoreDataRepository.swift
//  ThirdwayvChallenge
//
//  Created by Mohamed Shiha on 12/19/22.
//

import Foundation
import CoreData

class CoreDataRepository<T: NSManagedObject>: Repository {
	
	typealias Entity = T
	
	/// The NSManagedObjectContext instance to be used for performing the operations.
	private let managedObjectContext: NSManagedObjectContext
	
	/// Designated initializer.
	/// - Parameter managedObjectContext: The NSManagedObjectContext instance to be used for performing the operations.
	init(managedObjectContext: NSManagedObjectContext) {
		self.managedObjectContext = managedObjectContext
	}
	
	/// Gets an array of NSManagedObject entities.
	/// - Parameters:
	///   - predicate: The predicate to be used for fetching the entities.
	///   - sortDescriptors: The sort descriptors used for sorting the returned array of entities.
	/// - Returns: A result consisting of either an array of NSManagedObject entities or an Error.
	func get(predicate: NSPredicate?, sortDescriptors: [NSSortDescriptor]?) -> Result<[Entity], CoreDataError> {
		// Create a fetch request for the associated NSManagedObjectContext type.
		let fetchRequest = Entity.fetchRequest()
		fetchRequest.predicate = predicate
		fetchRequest.sortDescriptors = sortDescriptors
		do {
			// Perform the fetch request
			if let fetchResults = try managedObjectContext.fetch(fetchRequest) as? [Entity] {
				try? managedObjectContext.save()
				return .success(fetchResults)
			} else {
				return .failure(.invalidManagedObjectType)
			}
		} catch {
			return .failure(.fetchError)
		}
	}
	
	/// Creates a NSManagedObject entity.
	/// - Returns: A result consisting of either a NSManagedObject entity or an Error.
	func create() -> Result<Entity, CoreDataError> {
		let className = String(describing: Entity.self)
		guard let managedObject = NSEntityDescription.insertNewObject(forEntityName: className, into: managedObjectContext) as? Entity else {
			return .failure(.invalidManagedObjectType)
		}
		try? managedObjectContext.save()
		return .success(managedObject)
	}
	
	/// Deletes a NSManagedObject entity.
	/// - Parameter entity: The NSManagedObject to be deleted.
	/// - Returns: A result consisting of either a Bool set to true or an Error.
	func delete(entity: Entity) -> Result<Bool, CoreDataError> {
		managedObjectContext.delete(entity)
		try? managedObjectContext.save()
		return .success(true)
	}
	
	/// Deletes a NSManagedObject entity.
	/// - Returns: A result consisting of either a Bool set to true or an Error.
	func batchDelete() -> Result<Bool, CoreDataError> {
		let fetchRequest = Entity.fetchRequest()
		let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
		do {
			// Perform the fetch request
			if try managedObjectContext.fetch(fetchRequest) is [Entity] {
				do {
					// Perform the delete request
					try managedObjectContext.execute(deleteRequest)
					try managedObjectContext.save()
					return .success(true)
				} catch {
					return .failure(.deletingError)
				}
			} else {
				return .failure(.invalidManagedObjectType)
			}
		} catch {
			return .failure(.fetchError)
		}
	}
}

