//
//  Receipt.swift
//  KivraCase
//
//  Created by Jose Bolivar on 15/9/21.
//

import Foundation

protocol ReceiptProtocol: FileItem {
    func getReceiptKind() -> ReceiptType
}

// On the JSON I found this two types; more could be added to include all types
enum ReceiptType {
    case returnType
    case sale
    // ... //
    var typeLabel: String {
        switch self {
        case .returnType:
            return "RETUR"
        case .sale:
            return ""
        }
    }
}

// By abstracting the Receipt into a protocol we ensure the whole object is not shared,
// only the protocol with the functions to read or write, which is way safer.
struct Receipt {
    private var storeName: String
    private var purchaseDate: String
    private var receiptKind: ReceiptType

    init(title: String, date: String, receiptKind: ReceiptType) {
        self.storeName = title
        self.purchaseDate = date
        self.receiptKind = receiptKind
    }
}


// MARK: - ReceiptProtocol Extension
extension Receipt: ReceiptProtocol {
    var title: String {
        return self.storeName
    }

    var date: String {
        return self.purchaseDate
    }

    func getReceiptKind() -> ReceiptType {
        return self.receiptKind
    }
}
