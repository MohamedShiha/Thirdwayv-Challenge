//
//  ImageView+Extensions.swift
//  ThirdwayvChallenge
//
//  Created by Mohamed Shiha on 12/18/22.
//

import UIKit

extension UIImageView {
	func setImage(urlPath: String) {
		guard let url = URL(string: urlPath) else { return }
		
		DispatchQueue.global().async {
			guard let data = try? Data(contentsOf: url) else { return }
			DispatchQueue.main.async {
				self.image = UIImage(data: data)
			}
		}
	}
}
