//
//  ItemCollectionViewCellPresenter.swift
//  AvitoTest
//
//  Created by codela on 02/09/23.
//

import Foundation

protocol ItemCellsOutput {
    func loadImage(imageUrl: String)
    var view: ItemCells? { get set }
}

class ItemCollectionViewCellPresenter: ItemCellsOutput {

    private let imageManager: ImageManagerProtocol
    weak var view: ItemCells?
    
    init(imageManager: ImageManagerProtocol, view: ItemCells) {
        self.imageManager = imageManager
        self.view = view
    }
    
    func loadImage(imageUrl: String) {
        imageManager.fetchImage(imageUrl: imageUrl) { [weak self] result in
            switch result {
            case .success(let image):
                DispatchQueue.main.async {
                    self?.view?.setImage(image: image)
                }
            case .failure(_):
                break
            }
        }
    }
}
