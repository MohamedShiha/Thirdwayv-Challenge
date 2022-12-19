//
//  ProductManagedObject.swift
//  ThirdwayvChallenge
//
//  Created by Mohamed Shiha on 12/19/22.
//

import Foundation
import CoreData

@objc(ProductEntity)
class ProductEntity: NSManagedObject {
	
}

extension ProductEntity {
	
	@nonobjc public class func fetchRequest() -> NSFetchRequest<ProductEntity> {
		return NSFetchRequest<ProductEntity>(entityName: "ProductEntity")
	}
	
	// MARK: - Properties
	
	@NSManaged public var id: Int
	@NSManaged public var price: Int
	@NSManaged public var productDescription: String
	@NSManaged public var imageWidth: Int
	@NSManaged public var imageHeight: Int
	@NSManaged public var imageUrl: String
}

extension ProductEntity: DomainModelMapper {
	
	typealias DomainModelType = Product
	
	func toDomainModel() -> Product {
		Product(id: id,
				productDescription: productDescription,
				image: Image(width: imageWidth, height: imageHeight, url: imageUrl),
				price: price)
	}
}
