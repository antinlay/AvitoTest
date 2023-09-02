//
//  ItemData.swift
//  AvitoTest
//
//  Created by codela on 02/09/23.
//

import Foundation

struct ItemData: Codable {
    let id, title, price, location, imageUrl, createdDate: String
}

struct ResponseData: Codable {
    let advertisements: [ItemData]
}

struct ItemDetailData: Codable {
    let id, title, price, location, imageUrl, createdDate, description, email, phoneNumber, address: String
}

struct ItemDetailModel: Codable {
    let id, title, price, location: String
    let image: Data
    let createdDate, description, email, phoneNumber, address: String
}
