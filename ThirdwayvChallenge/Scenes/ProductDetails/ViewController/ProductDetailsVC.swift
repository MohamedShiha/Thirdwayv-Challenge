//
//  ProductDetailsVC.swift
//  ThirdwayvChallenge
//
//  Created by Mohamed Shiha on 12/18/22.
//

import UIKit

class ProductDetailsVC: ViewController {
	
	// MARK: - Variables
	
	var coordinator: MainCoordinator?
	
	// MARK: - Views
	
	private let closeButton: UIButton = {
		let button = UIButton()
		button.tintColor = .cyan
		button.setTitle("", for: .normal)
		button.setImage(UIImage(systemName: "xmark"), for: .normal)
		button.backgroundColor = .init(white: 1, alpha: 0.4)
		return button
	}()
	private let verticalStack: UIStackView = {
		let vStack = UIStackView()
		vStack.alignment = .center
		vStack.distribution = .fillEqually
		vStack.axis = .vertical
		return vStack
	}()
	private let productImageView = ImageViewLoader(image: nil)
	private let priceLabel: UILabel = {
		let label = UILabel(frame: .zero)
		label.textColor = UIColor(displayP3Red: 35 / 255,
								  green: 118 / 255,
								  blue: 140 / 255,
								  alpha: 1)
		label.font = UIFont.boldSystemFont(ofSize: 36)
		return label
	}()
	private let descriptionLabel: UILabel = {
		let label = UILabel()
		label.textAlignment = .center
		label.numberOfLines = 0
		return label
	}()

	// MARK: - Initializers
	
	init(product: Product) {
		super.init(nibName: nil, bundle: nil)
		setupViews()
		layoutViews()
		self.set(product: product)
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
	}
	
	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		closeButton.layer.cornerRadius = closeButton.bounds.height / 2
	}
	
	// MARK: - Setup
	
	func setupViews() {
		view.backgroundColor = .systemBackground
		view.addSubview(verticalStack)
		view.addSubview(closeButton)
		[productImageView, priceLabel, descriptionLabel]
			.forEach {
				verticalStack.addArrangedSubview($0)
			}
		
		[closeButton, verticalStack]
			.forEach {
				$0.translatesAutoresizingMaskIntoConstraints = false
			}
		productImageView.contentMode = .scaleToFill
		closeButton.addTarget(self, action: #selector(closeButtonOnTap(_:)), for: .touchUpInside)
	}
	
	func layoutViews() {
		NSLayoutConstraint.activate([
			closeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 16),
			closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
			closeButton.heightAnchor.constraint(equalToConstant: 44),
			closeButton.heightAnchor.constraint(equalTo: closeButton.widthAnchor),
			
			verticalStack.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			verticalStack.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			verticalStack.topAnchor.constraint(equalTo: view.topAnchor),
			verticalStack.bottomAnchor.constraint(equalTo: view.bottomAnchor)
		])
	}
	
	func set(product: Product) {
		productImageView.loadImageWith(urlPath: product.image.url)
		priceLabel.text = String(product.price)
		descriptionLabel.text = product.productDescription
	}
	
	// MARK: - Actions
	
	@objc
	private func closeButtonOnTap(_ sender: UIButton) {
		dismiss(animated: true)
	}
}
