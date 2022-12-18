//
//  APIRequestProtocol.swift
//  ThirdwayvChallenge
//
//  Created by Mohamed Shiha on 12/17/22.
//

import Foundation

protocol APIRequestProtocol: CustomStringConvertible {
    var scheme: URLScheme { get }
    var portNumber: Int? { get }
    var host: String { get }
    var path: String { get }
    var url: URL? { get }
    var method: HTTPMethod { get }
    var queryBody: Any? { get }
    var headers: [String: String] { get set }
    var authorization: APIAuthorization { get }
    var request: URLRequest? { get }
}

enum HTTPMethod: String {
    case options = "OPTIONS"
    case get     = "GET"
    case head    = "HEAD"
    case post    = "POST"
    case put     = "PUT"
    case patch   = "PATCH"
    case delete  = "DELETE"
    case trace   = "TRACE"
    case connect = "CONNECT"
}
