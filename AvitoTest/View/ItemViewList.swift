//
//  ItemViewList.swift
//  AvitoTest
//
//  Created by codela on 02/09/23.
//

import Foundation

class ItemListPresenter {
    
    private var itemManager: ItemManagerProtocol
    private var imageManager: ImageManagerProtocol
    private var items: [ItemData] = []
    
    weak var view: ItemListViewInput?
    var didTapToOpenItem: ((ItemData) -> Void)?
    
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
        itemManager.fetchItems { [weak self] result in
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
    
    func itemByIndex(index: Int) -> ItemData {
        return items[index]
    }
    
    func getImageManager() -> ImageManagerProtocol {
        return imageManager
    }
}
