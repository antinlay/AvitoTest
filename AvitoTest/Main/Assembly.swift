//
//  Assembly.swift
//  AvitoTest
//
//  Created by codela on 02/09/23.
//

import Foundation

protocol AssemblyProtocol {
    var apiRequestController: ApiRequestController { get }
    var networkController: NetworkControllerProtocol { get }
    var dateFormatter: FormatDateProtocol { get }
    var itemManager: ItemManagerProtocol { get }
    var imageManager: ImageManagerProtocol { get }
}

final class Assembly: AssemblyProtocol {
    lazy var apiRequestController: ApiRequestController = ApiRequestController()
    lazy var networkController: NetworkControllerProtocol = NetworkController()
    lazy var dateFormatter: FormatDateProtocol = FormatDate()
    lazy var itemManager: ItemManagerProtocol = ItemManager(networkController: networkController,
                                                                     requestManager: apiRequestController,
                                                                     dateFormatter: dateFormatter,
                                                                     imageManager: imageManager)
    lazy var imageManager: ImageManagerProtocol = ImageManager(networkController: networkController)
}
