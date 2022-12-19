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

enum ConnectionStatus {
	case connected
	case disconnected
}

final class NetworkMonitor {
	
	private let monitor = NWPathMonitor()
	private let queue = DispatchQueue(label: "monitor")
	var status: ConnectionStatus {
		return monitor.currentPath.status == .satisfied ? .connected : .disconnected
	}
	static let infoKey = "status"
	
	init() {
		monitor.pathUpdateHandler = { path in
			let status: ConnectionStatus = path.status == .satisfied ? .connected : .disconnected
			let info: [String : ConnectionStatus] = [NetworkMonitor.infoKey : status]
			NotificationCenter.default.post(name: .networkStatusDidChange, object: nil, userInfo: info)
		}
		monitor.start(queue: queue)
	}
}
