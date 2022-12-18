//
//  BaseAPIRequest.swift
//  ThirdwayvChallenge
//
//  Created by Mohamed Shiha on 12/17/22.
//

import Foundation

struct GetRequest: APIRequestProtocol {
    var queryParams: [String: String]?
    var scheme: URLScheme
	var host: String {
		APIConstants.BASE_URL
	}
    var portNumber: Int?
    var path: String
	var authorization: APIAuthorization {
		return .none
	}
	var method: HTTPMethod {
		return .get
	}
    var queryBody: Any? = nil
    var headers: [String: String]

    var url: URL? {
        var urlComponents = URLComponents()
		urlComponents.scheme = self.scheme.rawValue
        urlComponents.port = portNumber
        urlComponents.path = "\(self.path)"
        urlComponents.host = self.host
        urlComponents.queryItems = queryParams?.map({ URLQueryItem(name: $0.key, value: $0.value)})
        return urlComponents.url
    }
	
    var request: URLRequest? {
		guard let url else { return nil }
        var request = URLRequest(url: url)
        switch authorization {
        case .none:
            break
        }
        request.allHTTPHeaderFields = headers
        request.httpMethod = self.method.rawValue
        var bodyData: Data?
        if let queryBody = self.queryBody as? [String: Any] {
            bodyData = try? JSONSerialization.data(withJSONObject: queryBody, options: [])
        } else if let queryBody = self.queryBody as? String {
            bodyData = queryBody.data(using: .utf8)
        }
        request.httpBody = bodyData
        return request
    }

	init(path: String) {
		scheme = .https
        headers = ["Content-Type": "application/json",
                   "Accept-Encoding": "gzip, deflate, br"]
		self.path = path
    }
	
    var description: String {
        "RequestURL : \(request?.url?.absoluteString ?? "")"
    }
}
