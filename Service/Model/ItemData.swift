//
//  ItemData.swift
//  AvitoTest
//
//  Created by codela on 02/09/23.
//

import Foundation

struct Advert: Codable {
    let id: String
    let title: String
    let price: String
    let location: String
    let imageUrl: String
    let createdDate: String
}

struct ItemData: Codable {
    let advert: [Advert]
}

struct ItemDetails: Codable {
    let id, title, price, location, imageUrl, createdDate: String
    let description: String
    let email: String
    let phoneNumber: String
    let address: String
}

struct AdvertDetails: Codable {
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
