//
//  APIResponses.swift
//  KivraCase
//
//  Created by Jose Bolivar on 15/9/21.
//

import Foundation

// 'Bridge' model between our App's model and the API response.

struct APIReceiptResponse: Codable {
    let resultsNumber: Int
    let receiptList: [singleReceiptResponse]

    enum CodingKeys: String, CodingKey {
        case resultsNumber = "total"
        case receiptList = "receipts"
    }
}


struct singleReceiptResponse: Codable {
    let title: String
    let date: String
    let receiptKind: String

    enum CodingKeys: String, CodingKey {
        case title = "store_name"
        case date = "purchase_date"
        case receiptKind = "type"
    }
}
