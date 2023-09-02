//
//  ItemData.swift
//  AvitoTest
//
//  Created by codela on 02/09/23.
//

import Foundation

struct ItemData: Codable {
    let id: String
    let title: String
    let price: String
    let location: String
    let imageUrl: String
    let createdDate: String
}

struct ResponseData: Codable {
    let advertisements: [ItemData]
}

struct ItemDetailData: Codable {
    let id: String
    let title: String
    let price: String
    let location: String
    let imageUrl: String
    let createdDate: String
    let description: String
    let email: String
    let phoneNumber: String
    let address: String
}

struct ItemDetailModel: Codable {
    let id: String
    let title: String
    let price: String
    let location: String
    let image: Data
    let createdDate: String
    let description: String
    let email: String
    let phoneNumber: String
    let address: String
}
