//
//  MainCoordinator.swift
//  ThirdwayvChallenge
//
//  Created by Mohamed Shiha on 12/17/22.
//

import UIKit

final class MainCoordinator: Coordinator {
	
	var navigationController: UINavigationController
	
	init() {
		navigationController = UINavigationController()
	}
	
	func start() {
		let productsListVC = CollectionViewController(viewModel: ProductListViewModel())
		navigationController.setViewControllers([productsListVC], animated: true)
	}
	
	func showProductDetails(_ product: Product) {
		
	}
}
