//
//  NavigationFlow.swift
//  AvitoTest
//
//  Created by codela on 02/09/23.
//

import UIKit

final class NavigationFlow {
    
    private let navigationViewController: UINavigationController
    private let assemby: AssamblyProtocol
    
    init(navigationViewController: UINavigationController, assemby: AssamblyProtocol) {
        self.navigationViewController = navigationViewController
        self.navigationViewController.navigationBar.tintColor = .black
        self.assemby = assemby
    }
    
    func start() {
        let itemListPresenter = ItemListPresenter(itemManager: assemby.itemManager, imageManager: assemby.imageManager)
        itemListPresenter.didTapToOpenItem = wantsToOpenItemDetail
        let itemListView = ItemListViewController(itemListPresenter: itemListPresenter)
        itemListPresenter.view = itemListView
        navigationViewController.pushViewController(itemListView, animated: true)
    }
    
    func wantsToOpenItemDetail(with item: Advert) {
        let itemPresenter = ItemPresenter(itemManager: assemby.itemManager, item: item)
        let itemView = ItemViewController(itemPresenter: itemPresenter)
        itemPresenter.view = itemView
        navigationViewController.pushViewController(itemView, animated: true)
    }
}
