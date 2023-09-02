//
//  NavigationFlow.swift
//  AvitoTest
//
//  Created by codela on 02/09/23.
//

import UIKit

final class NavigationFlow {
    
    private let navigationViewController: UINavigationController
    private let assambly: Assambly
    
    init(navigationViewController: UINavigationController, assambly: Assambly) {
        self.navigationViewController = navigationViewController
        self.navigationViewController.navigationBar.tintColor = .black
        self.assambly = assambly
    }
    
    func start() {
        let itemListPresenter = ItemListPresenter(itemManager: assambly.itemManager, imageManager: assambly.imageManager)
        itemListPresenter.didTapToOpenItem = wantsToOpenItemDetail
        let itemListView = ItemListViewController(itemListPresenter: itemListPresenter)
        itemListPresenter.view = itemListView
        navigationViewController.pushViewController(itemListView, animated: true)
    }
    
    func wantsToOpenItemDetail(with item: Advert) {
        let itemPresenter = ItemPresenter(itemManager: assambly.itemManager, item: item)
        let itemView = ItemViewController(itemPresenter: itemPresenter)
        itemPresenter.view = itemView
        navigationViewController.pushViewController(itemView, animated: true)
    }
}
