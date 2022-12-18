//
//  Product.swift
//  ThirdwayvChallenge
//
//  Created by Mohamed Shiha on 12/17/22.
//

import Foundation

struct Product: Codable, Identifiable {
	let id: Int
	let productDescription: String
	let image: Image
	let price: Int
}
