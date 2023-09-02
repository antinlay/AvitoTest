//
//  ApiRequestManager.swift
//  AvitoTest
//
//  Created by codela on 01/09/23.
//

import Foundation

protocol ApiRequestManagerProtocol {
    func mainJsonRequest() -> String
    func detailsIdRequest(id: String) -> String
}

final class ApiRequestManager : ApiRequestManagerProtocol {
    
    func mainJsonRequest() -> String {
        return "https://www.avito.st/s/interns-ios/main-page.json"
    }
    func detailsIdRequest(id: String) -> String {
        return "https://www.avito.st/s/interns-ios/details/\(id).json"
    }
}
