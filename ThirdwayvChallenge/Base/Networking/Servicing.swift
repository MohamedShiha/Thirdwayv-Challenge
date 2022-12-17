//
//  Servicing.swift
//  ThirdwayvChallenge
//
//  Created by Mohamed Shiha on 12/17/22.
//

import Foundation

protocol Servicing {
	func get<T: Codable>(endpoint: GetRequest) async throws -> T
}
