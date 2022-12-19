//
//  ProductsCollectionVC.swift
//  ThirdwayvChallenge
//
//  Created by Mohamed Shiha on 12/18/22.
//

import UIKit

class ProductsCollectionVC: ViewController {

	// MARK: - Variables
	
//	weak var coordinator: MainCoordinator?
	var coordinator: MainCoordinator?
	let viewModel: ProductListViewModel
	var products = [Product]()
	let transition = PopAnimator()
	
	// MARK: - Views
	
	private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
	
	// MARK: - Initializers
	
	init(viewModel: ProductListViewModel) {
		self.viewModel = viewModel
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		viewModel = ProductListViewModel()
		super.init(coder: coder)
	}
	
	// MARK: - Lifecycle
	
    override func viewDidLoad() {
        super.viewDidLoad()
		setupViews()
		layoutViews()
		fetchData()
    }
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		NotificationCenter.default.addObserver(self,
											   selector: #selector(collectionStatusOmChange(notification:)),
											   name: .networkStatusDidChange,
											   object: nil)
	}
	
	@objc
	private func collectionStatusOmChange(notification: NSNotification) {
		fetchData()
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		NotificationCenter.default.removeObserver(self)
	}
	
	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		collectionView.collectionViewLayout.invalidateLayout()
	}
	
	// MARK: - Setup
	
	func setupViews() {
		setupCollectionView()
		view.addSubview(collectionView)
		transitioningDelegate = self
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
		collectionView.prefetchDataSource = self
		collectionView.translatesAutoresizingMaskIntoConstraints = false
	}
	
	func layoutViews() {
		NSLayoutConstraint.activate([
			collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			collectionView.topAnchor.constraint(equalTo: view.topAnchor),
			collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
		])
	}
	
	func fetchData() {
		Task {
			do {
				self.products = try await viewModel.fetchProducts()
				DispatchQueue.main.async {
					self.collectionView.reloadData()
				}
			} catch let error as NetworkError {
				print(error.desciption)
			}
		}
	}
	
	func fetchMoreData() {
		Task {
			do {
				let fetchedProducts = try await viewModel.fetchMoreProducts()
				self.products.append(contentsOf: fetchedProducts)
				DispatchQueue.main.async {
					self.collectionView.reloadData()
				}
			} catch let error as NetworkError {
				print(error.desciption)
			}
		}
	}
}

// MARK: - UICollectionViewDataSource

extension ProductsCollectionVC: UICollectionViewDataSource {
	
	func numberOfSections(in collectionView: UICollectionView) -> Int {
		return 1
	}
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return products.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductItemCell.reuseId, for: indexPath) as? ProductItemCell else {
			return UICollectionViewCell()
		}
		cell.set(product: products[indexPath.row])
		return cell
	}
}

// MARK: - UICollectionViewDataSource

extension ProductsCollectionVC: UICollectionViewDataSourcePrefetching {
	func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
		fetchMoreData()
	}
}

// MARK: - UICollectionViewDelegate

extension ProductsCollectionVC: UICollectionViewDelegate {
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		self.coordinator?.showProductDetails(products[indexPath.row])
	}
}

// MARK: - FlowLayoutDelegate

extension ProductsCollectionVC: UICollectionViewDelegateFlowLayout {
	
	func collectionView(_ collectionView: UICollectionView,
						layout collectionViewLayout: UICollectionViewLayout,
						sizeForItemAt indexPath: IndexPath) -> CGSize {
		let widthPerItem = (collectionView.frame.width / 2) - 1
		let product = products[indexPath.row]
		let height = calculateCellHeight(for: product, in: widthPerItem)
		return CGSize(width: widthPerItem - 8, height: height)
	}
	
	func calculateCellHeight(for product: Product, in cellWidth: CGFloat) -> CGFloat {
		let imageHeight = CGFloat(product.image.height)
		let containerSize = product.productDescription.containerSize(in: CGSize(width: cellWidth,
																				height: .greatestFiniteMagnitude))
		return imageHeight + containerSize.height + 50.0
	}
}

extension ProductsCollectionVC: UIViewControllerTransitioningDelegate {
	func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
		guard
			let selectedIndexPathCell = collectionView.indexPathsForSelectedItems?.first,
			let selectedCell = collectionView.cellForItem(at: selectedIndexPathCell),
			let selectedCellSuperview = selectedCell.superview
		else {
			return nil
		}
		
		transition.originFrame = selectedCellSuperview.convert(selectedCell.frame, to: nil)
		transition.originFrame = CGRect(
			x: transition.originFrame.origin.x + 20,
			y: transition.originFrame.origin.y + 20,
			width: transition.originFrame.size.width - 40,
			height: transition.originFrame.size.height - 40
		)
		
		transition.direction = .present
		
		return transition
	}
	
	func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
		transition.direction = .dismiss
		return transition
	}
}
