//
//  Repository.swift
//  ThirdwayvChallenge
//
//  Created by Mohamed Shiha on 12/19/22.
//

import Foundation

protocol Repository {
	
	/// The entity managed by the repository.
	associatedtype Entity
	
	/// Gets an array of entities.
	/// - Parameters:
	///   - predicate: The predicate to be used for fetching the entities.
	///   - sortDescriptors: The sort descriptors used for sorting the returned array of entities.
	func get(predicate: NSPredicate?, sortDescriptors: [NSSortDescriptor]?) -> Result<[Entity], CoreDataError>
	
	/// Creates an entity.
	func create() -> Result<Entity, CoreDataError>
	
	/// Deletes an entity.
	/// - Parameter entity: The entity to be deleted.
	func delete(entity: Entity) -> Result<Bool, CoreDataError>
	
	/// Deletes all entities.
	func batchDelete() -> Result<Bool, CoreDataError>
}
