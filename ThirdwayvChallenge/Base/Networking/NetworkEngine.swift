//
//  NetworkEngine.swift
//  ThirdwayvChallenge
//
//  Created by Mohamed Shiha on 12/17/22.
//

import Foundation

final class NetworkEngine: Servicing {
	
	func get<T: Codable>(endpoint: GetRequest) async throws -> T {
		
		let sessionConfig = URLSessionConfiguration.default
		sessionConfig.httpAdditionalHeaders = endpoint.headers
		let session = URLSession(configuration: sessionConfig)
		guard let request = endpoint.request else {
			throw NetworkError.badUrl
		}
		
		let (data, response) = try await session.data(for: request)
		
		guard let httpResponse = response as? HTTPURLResponse,
				(200..<299).contains(httpResponse.statusCode) else {
			throw NetworkError.invalidResponse
		}
		
		guard let result = try? JSONDecoder().decode(T.self, from: data) else {
			throw NetworkError.decodingError
		}
		
		return result
	}
}
