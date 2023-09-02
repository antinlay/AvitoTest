//
//  File.swift
//  AvitoTest
//
//  Created by codela on 01/09/23.
//

import Foundation

protocol ItemManagerProtocol {
    func fetchItem(completion: @escaping (Result<[Advert], Error>) -> Void)
    func fetchItemDetails(id: String, completion: @escaping (Result<AdvertDetails, Error>) -> Void)
}

final class ItemManager: ItemManagerProtocol {
    private var networkManager: NetworkManagerProtocol
    private var requestManager: ApiRequestManagerProtocol
    //    private var dateFormatter: DateFormatterManagerProtocol
    private var imageManager: ImageManagerProtocol
    
    init(networkManager: NetworkManagerProtocol, requestManager: ApiRequestManagerProtocol, imageManager: ImageManagerProtocol) {
        self.networkManager = networkManager
        self.requestManager = requestManager
        self.imageManager = imageManager
    }
    
    func fetchItem(completion: @escaping (Result<[Advert], Error>) -> Void) {
        networkManager.makeRequest(url: requestManager.mainJsonRequest()) { [weak self] result in
            switch result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let itemData = try decoder.decode(ItemData.self, from: data)
                    let products = itemData.advert.map({Advert(id: $0.id,
                                                               title: $0.title,
                                                               price: $0.price,
                                                               location: $0.location,
                                                               imageUrl: $0.imageUrl,
                                                               createdDate: $0.createdDate)})
                    completion(.success(products))
                } catch let decodeError {
                    completion(.failure(decodeError))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchItemDetails(id: String, completion: @escaping (Result<AdvertDetails, Error>) -> Void) { networkManager.makeRequest(url: requestManager.detailsIdRequest(id: id)) { result in
            switch result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let product = try decoder.decode(ItemDetails.self, from: data)
                    self.imageService.fetchImage(imageUrl: product.imageUrl) { [weak self] result in
                        switch result {
                        case .success(let image):
                            completion(.success(AdvertDetails(id: product.id,
                                                              title: product.title,
                                                              price: product.price,
                                                              location: product.location,
                                                              image: image,
                                                              createdDate: product.createdDate,
                                                              description: product.description,
                                                              email: product.email,
                                                              phoneNumber: product.phoneNumber,
                                                              address: product.address)))
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
