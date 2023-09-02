//
//  ImageManager.swift
//  AvitoTest
//
//  Created by antinlay on 02/09/23.
//

import Foundation

protocol ImageManagerProtocol {
    func fetchImage(imageUrl: String, completion: @escaping (Result<Data, Error>) -> Void)
}

final class ImageManager: ImageManagerProtocol {
    private var imageCache = NSCache<NSString, NSData>()
    private let networkController: NetworkControllerProtocol
    
    init(networkController: NetworkControllerProtocol) {
        self.networkController = networkController
    }
    
    func fetchImage(imageUrl: String, completion: @escaping (Result<Data, Error>) -> Void) {
        let key = imageUrl as NSString
        if let data = imageCache.object(forKey: key) {
            completion(.success(data as Data))
            return
        }
        networkController.makeRequest(url: imageUrl) { [weak self] result in
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
