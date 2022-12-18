//
//  ProductItemCell.swift
//  ThirdwayvChallenge
//
//  Created by Mohamed Shiha on 12/18/22.
//

import UIKit

class ProductItemCell: UICollectionViewCell {
	
	// MARK: Variables
	
	static let reuseId = "ProductItem"
	
	// MARK: Views
	
	private let productImageView: UIImageView = UIImageView(image: nil)
	private let verticalStack: UIStackView = {
		let vStack = UIStackView()
		vStack.axis = .vertical
		vStack.alignment = .center
		vStack.distribution = .fill
		return vStack
	}()
	private let priceLabel: UILabel = {
		let label = UILabel(frame: .zero)
		label.text = "1000"
		label.textColor = UIColor(displayP3Red: 35 / 255,
								  green: 118 / 255,
								  blue: 140 / 255,
								  alpha: 1)
		label.font = UIFont.boldSystemFont(ofSize: 24)
		return label
	}()
	private let descriptionLabel: UILabel = {
		let label = UILabel()
		label.textAlignment = .center
		label.numberOfLines = 0
		return label
	}()
	
	// MARK: Initialization
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupCell()
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		setupCell()
	}
	
	// MARK: Setup
	
	private func setupCell() {
		setupViews()
		layoutViews()
	}
	
	private func setupViews() {
		contentView.layer.borderWidth = 1
		contentView.addSubview(verticalStack)
		[productImageView, priceLabel, descriptionLabel]
			.forEach {
				verticalStack.addArrangedSubview($0)
			}
		
		[verticalStack, productImageView, priceLabel]
			.forEach {
				$0.translatesAutoresizingMaskIntoConstraints = false
			}
		
		productImageView.contentMode = .scaleToFill
	}
	
	private func layoutViews() {
		
		NSLayoutConstraint.activate([
			verticalStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
			verticalStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
			verticalStack.topAnchor.constraint(equalTo: contentView.topAnchor),
			verticalStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
			
			priceLabel.heightAnchor.constraint(equalToConstant: 44),
			
			descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
			descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
			descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
		])
	}
	
	func set(product: Product) {
		productImageView.setImage(urlPath: product.image.url)
		productImageView.frame.size = CGSize(width: product.image.width,
											 height: product.image.height)
		priceLabel.text = "\(product.price)"
		descriptionLabel.text = product.productDescription
	}
}
