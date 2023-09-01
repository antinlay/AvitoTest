//
//  NetworkManager.swift
//  AvitoTest
//
//  Created by codela on 01/09/23.
//

import Foundation

protocol NetworkManagerProtocol {
    func makeRequest(url: String, completion: @escaping (Result<Data, Error>) -> Void
}

final class NetworkManager : NetworkManagerProtocol {
    func makeRequest(url: String, completion: @escaping (Result<Data, Error>) -> Void) {
        guard let url = URL(string: url) else {
            completion(.failure(URLError(.badURL)))
            return
        }
        let session = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                completion(.success(data))
            }
        }
        session.resume()
    }
}
