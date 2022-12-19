//
//  ImageViewLoader.swift
//  ThirdwayvChallenge
//
//  Created by Mohamed Shiha on 12/19/22.
//

import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()

class ImageViewLoader: UIImageView {
	
	var imageURL: URL?
	
	let activityIndicator = UIActivityIndicatorView()
	
	func loadImageWith(urlPath: String) {
		
		guard let url = URL(string: urlPath) else { return }
		
		// setup activityIndicator...
		activityIndicator.color = .darkGray
		
		addSubview(activityIndicator)
		activityIndicator.translatesAutoresizingMaskIntoConstraints = false
		activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
		activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
		
		imageURL = url
		
		image = nil
		activityIndicator.startAnimating()
		
		// Retrieves image if already available in cache
		if let imageFromCache = imageCache.object(forKey: url as AnyObject) as? UIImage {
			self.image = imageFromCache
			activityIndicator.stopAnimating()
			return
		}
		
		// image does not available in cache.. so retrieving it from url...
		URLSession.shared.dataTask(with: url) { (data, response, error) in
			
			guard error == nil else {
				print(error as Any)
				DispatchQueue.main.async {
					self.activityIndicator.stopAnimating()
				}
				return
			}
			
			DispatchQueue.main.async {
				
				if let unwrappedData = data, let imageToCache = UIImage(data: unwrappedData) {
					
					if self.imageURL == url {
						self.image = imageToCache
					}
					
					imageCache.setObject(imageToCache, forKey: url as AnyObject)
				}
				self.activityIndicator.stopAnimating()
			}
		}.resume()
	}
}
