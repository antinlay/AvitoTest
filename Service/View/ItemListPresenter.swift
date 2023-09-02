//
//  ItemListPresenter.swift
//  AvitoTest
//
//  Created by codela on 02/09/23.
//

import Foundation

class ItemListPresenter {
    // MARK: - Private properties
    private var itemManager: ItemManagerProtocol
    private var imageManager: ImageManagerProtocol
    private var items: [Advert] = []
    // MARK: - Public properties
    weak var view: ItemListView?
    var didTapToOpenItem: ((Advert) -> Void)?
    // MARK: - Init
    init(itemManager: ItemManagerProtocol, imageManager: ImageManagerProtocol) {
        self.itemManager = itemManager
        self.imageManager = imageManager
    }
}

extension ItemListPresenter: ItemListViewOutput {
    func viewDidTapToOpenItem(with index: Int) {
        didTapToOpenItem?(items[index])
    }
    func loadItems() {
        view?.showLoading()
        itemManager.fetchItem { [weak self] result in
            switch result {
            case .success(let items):
                self?.items = items
                DispatchQueue.main.async {
                    self?.view?.updateCollectionView()
                }
            case .failure:
                DispatchQueue.main.async {
                    self?.view?.showError()
                }
            }
        }
    }
    func itemsCount() -> Int {
        return items.count
    }
    
    func itemByIndex(index: Int) -> Advert {
        return items[index]
    }
    
    func getImageManager() -> ImageManagerProtocol {
        return imageManager
    }
}
