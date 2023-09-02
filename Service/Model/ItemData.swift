//
//  ItemData.swift
//  AvitoTest
//
//  Created by codela on 02/09/23.
//

import Foundation

struct ItemData: Codable {
    let advert: [Advert]
}

struct Advert: Codable {
    let id: String
    let title: String
    let price: String
    let location: String
    let imageUrl: String
    let createdDate: String
    
    enum CodingKeys: String, CodingKey {
        case id, title, price, location
        case imageUrl = "image_url"
        case createdDate = "created_date"
    }
}
