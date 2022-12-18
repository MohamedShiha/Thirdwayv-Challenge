//
//  ProductListViewModel.swift
//  ThirdwayvChallenge
//
//  Created by Mohamed Shiha on 12/17/22.
//

import Foundation

final class ProductListViewModel {
	
	let networkEngine: NetworkEngine
	
	init() {
		networkEngine = NetworkEngine()
	}
	
	func fetchProducts() async throws -> [Product] {
		return try await networkEngine.get(endpoint: ProductsListService.endpoint.request)
	}
}
