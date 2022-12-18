//
//  ProductsCollectionVC.swift
//  ThirdwayvChallenge
//
//  Created by Mohamed Shiha on 12/18/22.
//

import UIKit

class ProductsCollectionVC: UICollectionViewController, TemplateViewController {

	weak var coordinator: MainCoordinator?
	let viewModel: ProductListViewModel
	var products = [Product]()
	
	init(viewModel: ProductListViewModel) {
		self.viewModel = viewModel
		super.init(collectionViewLayout: UICollectionViewLayout())
	}
	
	required init?(coder: NSCoder) {
		viewModel = ProductListViewModel()
		super.init(coder: coder)
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()

		setupViews()
		layoutViews()
    }
	
	func setupViews() {
		setupCollectionView()
	}
	
	private func setupCollectionView() {
		collectionView.register(ProductItemCell.self, forCellWithReuseIdentifier: ProductItemCell.reuseId)
		let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
		layout.minimumInteritemSpacing = 0
		layout.minimumLineSpacing = 0
		layout.minimumInteritemSpacing = 0
		collectionView.setCollectionViewLayout(layout, animated: true)
		collectionView.dataSource = self
		collectionView.delegate = self
	}
	
	func layoutViews() { }
	
	func fetchData() {
		Task {
			do {
				self.products = try await viewModel.fetchProducts()
			} catch let error as NetworkError {
				print(error.desciption)
			}
		}
	}
}

// MARK: UICollectionViewDataSource

extension ProductsCollectionVC {
	
	override func numberOfSections(in collectionView: UICollectionView) -> Int {
		return 1
	}
	
	override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return products.count
	}
	
	override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductItemCell.reuseId, for: indexPath) as? ProductItemCell else {
			return UICollectionViewCell()
		}
		cell.set(product: products[indexPath.row])
		return cell
	}
}

// MARK: UICollectionViewDelegate

extension ProductsCollectionVC {
	override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		coordinator?.showProductDetails(products[indexPath.row])
	}
}

// MARK: FlowLayoutDelegate

extension ProductsCollectionVC: UICollectionViewDelegateFlowLayout {
	
	func collectionView(_ collectionView: UICollectionView,
						layout collectionViewLayout: UICollectionViewLayout,
						sizeForItemAt indexPath: IndexPath) -> CGSize {
		let widthPerItem = (collectionView.frame.width / 2) - 1
		let product = products[indexPath.row]
		let height = calculateHeight(for: product, in: widthPerItem)
		return CGSize(width: widthPerItem - 8, height: height)
	}
	
	func calculateHeight(for product: Product, in cellWidth: CGFloat) -> CGFloat {
		let imageHeight = CGFloat(product.image.height)
		let containerSize = product.productDescription.containerSize(in: CGSize(width: cellWidth,
																				height: .greatestFiniteMagnitude))
		return imageHeight + containerSize.height + 50.0
	}
}
