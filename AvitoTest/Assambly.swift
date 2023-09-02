//
//  Assambly.swift
//  AvitoTest
//
//  Created by codela on 01/09/23.
//

import Foundation

protocol AssamblyProtocol {
    var apiRequestManager: ApiRequestManagerProtocol {get}
    var networkManager: NetworkManagerProtocol {get}
    var itemManager: ItemManagerProtocol {get}
    var imageManager: ImageManagerProtocol {get}
}

final class Assambly {
    lazy var apiRequestManager: ApiRequestManager = ApiRequestManager()
    lazy var networkManager: NetworkManagerProtocol = NetworkManager()
    lazy var imageManager: ImageManagerProtocol = ImageManager(networkManager: networkManager)
    lazy var itemManager: ItemManagerProtocol = ItemManager(networkManager: networkManager, requestManager: apiRequestManager, imageManager: imageManager)
}
