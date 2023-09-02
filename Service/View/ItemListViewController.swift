//
//  ItemListViewController.swift
//  AvitoTest
//
//  Created by codela on 02/09/23.
//

import UIKit

protocol View: AnyObject {
    func showLoading()
    func showError()
}

protocol ItemListView: AnyObject, View {
    func updateCollectionView()
}

protocol ItemListViewOutput {
    func viewDidTapToOpenItem(with index: Int)
    func loadItems()
    func itemsCount() -> Int
    func itemByIndex(index: Int) -> Advert
    func getImageManager() -> ImageManagerProtocol
}

class ItemListViewController: UIViewController {
    // MARK: - Private constants
    private enum UIConstants {
        static let errorLabelFontSize: CGFloat = 20
        static let contentInset: CGFloat = 16
        static let itemCellHeight: CGFloat = 280
    }
    // MARK: - Private UI properties
    private lazy var itemCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: CGRect(), collectionViewLayout: layout)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = UIColor(named: "collectionViewBackgroundColor")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    private lazy var loadingView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.color = .black
        view.hidesWhenStopped = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private lazy var errorLabel: UILabel = {
        let label = UILabel()
        label.text = TextData.error
        label.font = UIFont.boldSystemFont(ofSize: UIConstants.errorLabelFontSize)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isHidden = true
        return label
    }()
    // MARK: - Private properties
    private let itemListPresenter: ItemListViewOutput
    // MARK: - Init
    init(itemListPresenter: ItemListViewOutput) {
        self.itemListPresenter = itemListPresenter
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - UIViewController life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        showLoading()
        itemListPresenter.loadItems()
    }
    // MARK: - Private functions
    private func setupView() {
        navigationItem.title = ""
        view.backgroundColor = .white
        [itemCollectionView, loadingView, errorLabel].forEach({view.addSubview($0)})
        setupCollectionView()
        setupContraints()
    }
    private func setupContraints() {
        NSLayoutConstraint.activate([
            itemCollectionView.topAnchor.constraint(equalTo: view.topAnchor),
            itemCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            itemCollectionView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            itemCollectionView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            
            loadingView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            errorLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            errorLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    private func setupCollectionView() {
        itemCollectionView.delegate = self
        itemCollectionView.dataSource = self
        itemCollectionView.register(ItemCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: ItemCollectionViewCell.self))
    }
}
extension ItemListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemListPresenter.itemsCount()
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: String(describing: ItemCollectionViewCell.self),
            for: indexPath) as? ItemCollectionViewCell else { return ItemCollectionViewCell()}
        let cellPresenter: ItemCellsOutput = ItemCollectionViewCellPresenter(imageManager: itemListPresenter.getImageManager(),
                                                                                  view: cell)
        cell.configure(with: itemListPresenter.itemByIndex(index: indexPath.row), presenter: cellPresenter)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        itemListPresenter.viewDidTapToOpenItem(with: indexPath.row)
    }
}
extension ItemListViewController: ItemListView {
    func showLoading() {
        loadingView.startAnimating()
        errorLabel.isHidden = true
    }
    
    func showError() {
        loadingView.stopAnimating()
        errorLabel.isHidden = false
        itemCollectionView.isHidden = true
    }
    
    func updateCollectionView() {
        loadingView.stopAnimating()
        errorLabel.isHidden = true
        itemCollectionView.isHidden = false
        itemCollectionView.reloadData()
    }
}
extension ItemListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewWidth = collectionView.bounds.width - 16
        let itemHeight = UIConstants.itemCellHeight
        let itemWidth = collectionViewWidth / 2
        return CGSize(width: Double(itemWidth), height: Double(itemHeight))
    }
}

