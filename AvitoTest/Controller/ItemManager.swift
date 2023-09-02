//
//  ItemManager.swift
//  AvitoTest
//
//  Created by antinlay on 02/09/23.
//

import Foundation

protocol ItemManagerProtocol {
    func fetchItems(completion: @escaping (Result<[ItemData], Error>) -> Void)
    func fetchItemDetailById(id: String, completion: @escaping (Result<ItemDetailModel, Error>) -> Void)
}

final class ItemManager: ItemManagerProtocol {
    private var networkController: NetworkControllerProtocol
    private var requestManager: ApiRequestControllerProtocol
    private var dateFormatter: FormatDateProtocol
    private var imageManager: ImageManagerProtocol
    
    init(networkController: NetworkControllerProtocol, requestManager: ApiRequestControllerProtocol,
         dateFormatter: FormatDateProtocol, imageManager: ImageManagerProtocol) {
        self.networkController = networkController
        self.requestManager = requestManager
        self.dateFormatter = dateFormatter
        self.imageManager = imageManager
    }
    
    func fetchItems(completion: @escaping (Result<[ItemData], Error>) -> Void) {
        networkController.makeRequest(url: requestManager.mainPageRequest()) { [weak self] result in
            switch result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let responseData = try decoder.decode(ResponseData.self, from: data)
                    let items = responseData.advertisements.map({ItemData(id: $0.id,
                                                                                title: $0.title,
                                                                                price: $0.price,
                                                                                location: $0.location,
                                                                                imageUrl: $0.imageUrl,
                                                                                createdDate: self?.dateFormatter.formatDate(stringDate: $0.createdDate) ?? "")})
                    completion(.success(items))
                } catch let decodeError {
                    completion(.failure(decodeError))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchItemDetailById(id: String, completion: @escaping (Result<ItemDetailModel, Error>) -> Void) {
        networkController.makeRequest(url: requestManager.itemByIdRequest(id: id)) { result in
            switch result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let item = try decoder.decode(ItemDetailData.self, from: data)
                    self.imageManager.fetchImage(imageUrl: item.imageUrl) { [weak self] result in
                        switch result {
                        case .success(let image):
                            completion(.success(ItemDetailModel(id: item.id,
                                                                   title: item.title,
                                                                   price: item.price,
                                                                   location: item.location,
                                                                   image: image,
                                                                   createdDate: self?.dateFormatter.formatDate(stringDate: item.createdDate) ?? "",
                                                                   description: item.description,
                                                                   email: item.email,
                                                                   phoneNumber: item.phoneNumber,
                                                                   address: item.address)))
                        case .failure(let error):
                            completion(.failure(error))
                        }
                    }
                } catch let decodeError {
                    completion(.failure(decodeError))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
