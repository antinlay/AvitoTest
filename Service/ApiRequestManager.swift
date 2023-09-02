//
//  ApiRequestManager.swift
//  AvitoTest
//
//  Created by codela on 01/09/23.
//

import Foundation

protocol ApiRequestManagerProtocol {
    func detailsIdRequest(id: String) -> String
    func mainJsonRequest() -> String
}

final class ApiRequestManager : ApiRequestManagerProtocol {
    func detailsIdRequest(id: String) -> String {
        return "https://www.avito.st/s/interns-ios/details/\(id).json"
    }
    func mainJsonRequest() -> String {
        return "https://www.avito.st/s/interns-ios/main-page.json"
    }
}
