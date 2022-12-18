//
//  APIAuthorization.swift
//  ThirdwayvChallenge
//
//  Created by Mohamed Shiha on 12/17/22.
//

import Foundation

enum APIAuthorization {
    case none
    var authData: Any {
        switch self {
        case .none:
			return [:]
        }
    }
}
