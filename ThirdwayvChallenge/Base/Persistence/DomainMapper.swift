//
//  DomainMapper.swift
//  ThirdwayvChallenge
//
//  Created by Mohamed Shiha on 12/19/22.
//

import Foundation

/// A template that enables clients to map types into models
protocol DomainModelMapper {
	associatedtype DomainModelType
	/// Converts a client type into a specific type
	/// - Returns: An model of a specific type.
	func toDomainModel() -> DomainModelType
}
