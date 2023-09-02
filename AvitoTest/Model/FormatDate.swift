//
//  FormatDate.swift
//  AvitoTest
//
//  Created by antinlay on 02/09/23.
//

import Foundation

protocol FormatDateProtocol {
    func formatDate(stringDate: String) -> String?
}

final class FormatDate:FormatDateProtocol {
    
    func formatDate(stringDate: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        dateFormatter.timeZone = TimeZone(secondsFromGMT: -10800)
        guard let date = dateFormatter.date(from: stringDate) else {return nil}
        dateFormatter.dateFormat = "d MMMM"
        return dateFormatter.string(from: date)
    }
}
