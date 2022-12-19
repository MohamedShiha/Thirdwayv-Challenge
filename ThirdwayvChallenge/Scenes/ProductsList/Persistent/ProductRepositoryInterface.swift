//
//  ProductRepositoryInterface.swift
//  ThirdwayvChallenge
//
//  Created by Mohamed Shiha on 12/19/22.
//

import Foundation
import CoreData

protocol ProductRepositoryInterface {
	/// Get products using a predicate
	/// - Parameters:
	///   - predicate: a predicate to match specific entities.
	/// - Returns:
	///   - List of products in case of successful fetch
	func getProducts(predicate: NSPredicate?) -> Result<[Product], Error>
	/// Creates a product in the storage object.
	/// - Parameters:
	///   - product: a model to be created.
	/// - Returns:
	///   - Success or error depending on operation status.
	func create(product: Product) -> Result<Bool, Error>
	/// Deletes a NSManagedObject entity.
	/// - Returns:
	///   - Success or error depending on operation status.
	func batchDelete() -> Result<Bool, CoreDataError>
}

/// Product Repository class.
class ProductsRepository {
	/// The Core Data Product repository.
	private let repository: CoreDataRepository<ProductEntity>
	
	/// Creates a repository object using NSManagedObject
	/// - Parameter context: The context used for storing and quering Core Data.
	init(context: NSManagedObjectContext) {
		self.repository = CoreDataRepository<ProductEntity>(managedObjectContext: context)
	}
}

extension ProductsRepository: ProductRepositoryInterface {
	/// Get products using a predicate
	/// - Parameters:
	///   - predicate: a predicate to match specific entities.
	/// - Returns:
	///   - List of products in case of successful fetch
	func getProducts(predicate: NSPredicate?) -> Result<[Product], Error> {
		let result = repository.get(predicate: predicate, sortDescriptors: nil)
		switch result {
		case .success(let productMO):
			// Transform the NSManagedObject objects to domain objects
			let products = productMO.map { productMO -> Product in
				return productMO.toDomainModel()
			}
			return .success(products)
		case .failure(let error):
			// Return the Core Data error.
			return .failure(error)
		}
	}
	
	/// Creates a product in the storage object.
	/// - Parameters:
	///   - product: a model to be created.
	/// - Returns:
	///   - Success or error depending on operation status.
	@discardableResult func create(product: Product) -> Result<Bool, Error> {
		let result = repository.create()
		switch result {
		case .success(let productMO):
			// Update the book properties.
			productMO.id = product.id
			productMO.price = product.price
			productMO.productDescription = product.productDescription
			productMO.imageUrl = product.image.url
			productMO.imageWidth = product.image.width
			productMO.imageHeight = product.image.height
			
			return .success(true)
			
		case .failure(let error):
			// Return the Core Data error.
			return .failure(error)
		}
	}
	
	/// Deletes a NSManagedObject entity.
	/// - Returns:
	///   - Success or error depending on operation status.
	@discardableResult func batchDelete() -> Result<Bool, CoreDataError> {
		repository.batchDelete()
	}
}
