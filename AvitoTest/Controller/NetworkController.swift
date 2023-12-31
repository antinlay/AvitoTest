//
//  NetworkController.swift
//  AvitoTest
//
//  Created by antinlay on 02/09/23.
//

import Foundation

protocol NetworkControllerProtocol {
    func makeRequest(url: String, completion: @escaping (Result<Data, Error>) -> Void)
}

final class NetworkController: NetworkControllerProtocol {

    func makeRequest(url: String, completion: @escaping (Result<Data, Error>) -> Void) {
        guard let url = URL(string: url)
        else {
            completion(.failure(URLError(.badURL)))
            return
        }
        let request = URLRequest(url: url)
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                completion(.success(data))
            }
        }
        task.resume()
    }
}
