//
//  DetailPresenter.swift
//  AvitoTest
//
//  Created by codela on 02/09/23.
//

import Foundation

final class ItemPresenter: ItemViewOutput {
    
    // MARK: - Private properties
    private var itemManager: ItemManagerProtocol
    private var item: Advert
    // MARK: - Public properties
    weak var view: ItemView?
    var itemDetail: AdvertDetails?
    // MARK: - Init
    init(itemManager: ItemManagerProtocol, item: Advert) {
        self.itemManager = itemManager
        self.item = item
    }
    // MARK: -
    func loadItemDetail() {
        view?.showLoading()
        itemManager.fetchItemDetails(id: item.id) { [weak self] result in
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
