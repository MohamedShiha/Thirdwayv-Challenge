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
		let productsListVC = ProductsCollectionVC(viewModel: ProductListViewModel())
		productsListVC.coordinator = self
		navigationController.setViewControllers([productsListVC], animated: true)
	}
	
	func showProductDetails(_ product: Product) {
		let productDetailsVC = ProductDetailsVC(product: product)
		productDetailsVC.coordinator = self
		navigationController.present(productDetailsVC, animated: true)
	}
}
