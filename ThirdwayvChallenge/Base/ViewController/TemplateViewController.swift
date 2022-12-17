//
//  TemplateViewController.swift
//  ThirdwayvChallenge
//
//  Created by Mohamed Shiha on 12/17/22.
//

import Foundation
import class UIKit.UIViewController

typealias ViewController = UIViewController & TemplateViewController

protocol TemplateViewController: AnyObject {
	var coordinator: MainCoordinator? { get }
	func setupViews()
	func layoutViews()
}

