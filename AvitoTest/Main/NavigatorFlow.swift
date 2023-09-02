//
//  NavigatorFlow.swift
//  AvitoTest
//
//  Created by codela on 02/09/23.
//

import UIKit

final class NavigatorFlow {
    
    private let navigationViewController: UINavigationController
    private let assembly: AssemblyProtocol
    
    init(navigationViewController: UINavigationController, assembly: AssemblyProtocol) {
        self.navigationViewController = navigationViewController
        self.navigationViewController.navigationBar.tintColor = .black
        self.assembly = assembly
    }
    
    func start() {
        let itemListPresenter = ItemListPresenter(itemManager: assembly.itemManager, imageManager: assembly.imageManager)
        itemListPresenter.didTapToOpenItem = wantsToOpenItemDetail
        let itemListView = ItemListViewController(itemListPresenter: itemListPresenter)
        itemListPresenter.view = itemListView
        navigationViewController.pushViewController(itemListView, animated: true)
    }
    
    func wantsToOpenItemDetail(with item: ItemData) {
        let detailPresenter = DetailPresenter(itemManager: assembly.itemManager, item: item)
        let detailView = ItemViewController(detailPresenter: detailPresenter)
        detailPresenter.view = detailView
        navigationViewController.pushViewController(detailView, animated: true)
    }
}
