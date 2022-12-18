//
//  String+Extensions.swift
//  ThirdwayvChallenge
//
//  Created by Mohamed Shiha on 12/18/22.
//

import Foundation

extension String {
	func containerSize(in size: CGSize) -> CGSize {
		let constraintRect = CGSize(width: size.width, height: size.height)
		let boundingBox = self.boundingRect(with: constraintRect,
											options: .usesLineFragmentOrigin,
											attributes: nil,
											context: nil)
		return boundingBox.size
	}
}
