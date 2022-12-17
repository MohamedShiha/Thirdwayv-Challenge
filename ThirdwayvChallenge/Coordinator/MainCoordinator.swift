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
		let productsListVC = ProductsListVC()
		productsListVC.coordinator = self
		navigationController.setViewControllers([productsListVC], animated: true)
	}
}
