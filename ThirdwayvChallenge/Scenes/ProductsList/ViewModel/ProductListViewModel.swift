//
//  ProductListViewModel.swift
//  ThirdwayvChallenge
//
//  Created by Mohamed Shiha on 12/17/22.
//

import Foundation

final class ProductListViewModel {
	
	let networkEngine: NetworkEngine
	let networkMonitor: NetworkMonitor
	
	init() {
		networkEngine = NetworkEngine()
		networkMonitor = NetworkMonitor()
	}
	
	func fetchProducts() async throws -> [Product] {
		if networkMonitor.status == .connected {
			let products: [Product] = try await networkEngine.get(endpoint: ProductsListService.endpoint.request)
			self.refreshProductsCache(products: products)
			return products
		}
		return getCachedProducts()
	}
	
	func fetchMoreProducts() async throws -> [Product] {
		return try await networkEngine.get(endpoint: ProductsListService.endpoint.request)
	}
	
	private func getCachedProducts() -> [Product] {
		let contextProvider = CoreDataContextProvider()
		let productsRepo = ProductsRepository(context: contextProvider.viewContext)
		let fetchResult = productsRepo.getProducts(predicate: nil)
		switch fetchResult {
		case .success(let products):
			return products
		case .failure:
			return []
		}
	}
	
	private func refreshProductsCache(products: [Product]) {
		let contextProvider = CoreDataContextProvider()
		let productsRepo = ProductsRepository(context: contextProvider.viewContext)
		productsRepo.batchDelete()
		products.forEach {
			productsRepo.create(product: $0)
		}
	}
}
