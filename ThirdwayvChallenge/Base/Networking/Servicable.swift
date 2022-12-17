//
//  Servicable.swift
//  ThirdwayvChallenge
//
//  Created by Mohamed Shiha on 12/17/22.
//

import Foundation

protocol Servicable {
	associatedtype Requestable: APIRequestProtocol
	var request: Requestable { get }
}
