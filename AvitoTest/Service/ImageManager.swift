//
//  ImageManager.swift
//  AvitoTest
//
//  Created by codela on 02/09/23.
//

import Foundation

protocol ImageManagerProtocol {
    func fetchImage(imageUrl: String, completion: @escaping (Result<Data, Error>) -> Void)
}

final class ImageManager: ImageManagerProtocol {
    private var imageCache = NSCache<NSString, NSData>()
    private let networkManager: NetworkManagerProtocol
    
    init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
    }
    
    func fetchImage(imageUrl: String, completion: @escaping (Result<Data, Error>) -> Void) {
        let key = imageUrl as NSString
        if let data = imageCache.object(forKey: key) {
            completion(.success(data as Data))
            return
        }
        networkManager.makeRequest(url: imageUrl) { [weak self] result in
            switch result {
            case .success(let data):
                let image = data as NSData
                self?.imageCache.setObject(image, forKey: key)
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
