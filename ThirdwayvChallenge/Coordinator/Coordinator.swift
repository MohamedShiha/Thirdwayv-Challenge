//
//  Coordinator.swift
//  ThirdwayvChallenge
//
//  Created by Mohamed Shiha on 12/17/22.
//

import Foundation
import class UIKit.UINavigationController

protocol Coordinator {
	var navigationController: UINavigationController { get set }
	func start()
}
