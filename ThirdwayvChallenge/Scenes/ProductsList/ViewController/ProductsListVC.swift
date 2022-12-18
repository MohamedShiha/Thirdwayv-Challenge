//
//  ProductsListVC.swift
//  ThirdwayvChallenge
//
//  Created by Mohamed Shiha on 12/17/22.
//

import UIKit

class ProductsListVC: ViewController {
	
	weak var coordinator: MainCoordinator?

	override func viewDidLoad() {
		super.viewDidLoad()
		setupViews()
		layoutViews()
		let engine = NetworkEngine()
		
		var products: [Product] = []
		Task {
			do {
				products = try await engine.get(endpoint: ProductsListService.endpoint.request)
				print(products)
			} catch let error as NetworkError {
				print(error.desciption)
			}
		}
	}
	
	func setupViews() {
		view.backgroundColor = .cyan
	}
	
	func layoutViews() {
		
	}
}
