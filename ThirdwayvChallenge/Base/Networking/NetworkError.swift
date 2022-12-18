//
//  NetworkError.swift
//  ThirdwayvChallenge
//
//  Created by Mohamed Shiha on 12/17/22.
//

import Foundation

enum NetworkError: Error {
	case invalidResponse
	case badUrl
	case noInternet
	case decodingError
	var desciption: String {
		switch self {
		case .invalidResponse:
			return "Invalid response."
		case .badUrl:
			return "Corrupt Url."
		case .noInternet:
			return "No internet or maybe the resouces don't exist."
		case .decodingError:
			return "Decoding error, JSON object doesn't match the specified model."
		}
	}
}
