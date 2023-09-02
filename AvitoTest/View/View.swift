//
//  View.swift
//  AvitoTest
//
//  Created by antinlay on 02/09/23.
//

import Foundation

final class DetailPresenter: ItemViewOutput {
    

    private var itemManager: ItemManagerProtocol
    private var item: ItemData

    weak var view: ItemViewInput?
    var itemDetail: ItemDetailModel?

    init(itemManager: ItemManagerProtocol, item: ItemData) {
        self.itemManager = itemManager
        self.item = item
    }

    func loadItemDetail() {
        view?.showLoading()
        itemManager.fetchItemDetailById(id: item.id) { [weak self] result in
            switch result {
            case .success(let itemDetail):
                self?.itemDetail = itemDetail
                DispatchQueue.main.async {
                    self?.view?.updateItemData(item: itemDetail)
                }
            case .failure(_):
                DispatchQueue.main.async {
                    self?.view?.showError()
                }
            }
        }
    }
}
