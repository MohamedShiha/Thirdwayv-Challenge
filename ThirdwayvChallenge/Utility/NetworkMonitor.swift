//
//  NetworkMonitor.swift
//  ThirdwayvChallenge
//
//  Created by Mohamed Shiha on 12/17/22.
//

import Foundation
import Network

extension Notification.Name {
	static let networkStatusDidChange = Notification.Name(rawValue: "NetworkStatusDidChange")
}

final class NetworkMonitor {
	
	private let monitor = NWPathMonitor()
	private let queue = DispatchQueue(label: "monitor")
	static let infoKey = "status"
	
	init() {
		monitor.pathUpdateHandler = { path in
			let info: [String:NWPath.Status] = [NetworkMonitor.infoKey:path.status]
			NotificationCenter.default.post(name: .networkStatusDidChange, object: nil, userInfo: info)
		}
		monitor.start(queue: queue)
	}
}
