//
//  ApiRequestController.swift
//  AvitoTest
//
//  Created by codela on 02/09/23.
//

import Foundation

protocol ApiRequestControllerProtocol {
    func mainPageRequest() -> String
    func itemByIdRequest(id: String) -> String
}

final class ApiRequestController: ApiRequestControllerProtocol {
    func mainPageRequest() -> String {
        return "https://www.avito.st/s/interns-ios/main-page.json"
    }
    func itemByIdRequest(id: String) -> String {
        return "https://www.avito.st/s/interns-ios/details/\(id).json"
    }
}
