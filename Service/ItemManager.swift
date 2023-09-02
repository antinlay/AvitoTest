//
//  File.swift
//  AvitoTest
//
//  Created by codela on 01/09/23.
//

import Foundation

protocol ItemManagerProtocol {
    func fetchItemDetails(id: String, completion: @escaping (Result<))
}
