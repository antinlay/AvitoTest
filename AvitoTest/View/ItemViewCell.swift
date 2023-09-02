//
//  ItemViewCell.swift
//  AvitoTest
//
//  Created by codela on 02/09/23.
//

import Foundation

protocol ItemCellOutput {
    func loadImage(imageUrl: String)
    var view: ItemCellInput? { get set }
}

class ItemCollectionViewCellPresenter: ItemCellOutput {

    private let imageManager: ImageManagerProtocol
    weak var view: ItemCellInput?
    
    init(imageManager: ImageManagerProtocol, view: ItemCellInput) {
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
