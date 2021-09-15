//
//  Receipt.swift
//  KivraCase
//
//  Created by Jose Bolivar on 15/9/21.
//

import Foundation

protocol ReceiptProtocol {
    func getTitle() -> String
    func getDate() -> String
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
struct Receipt: FileItem {

    internal var title: String  // declared internal because it matches a requirement in internal protoco
    internal var date: String
//    internal var logo: String       // This could be a URL returned from the API, but for now it's a static UI Symbol
    private var receiptKind: ReceiptType

    init(title: String, date: String, receiptKind: ReceiptType) {
        self.title = title
        self.date = date
        self.receiptKind = receiptKind
    }
}


// MARK: - ReceiptProtocol Extension
extension Receipt: ReceiptProtocol {
    func getTitle() -> String {
        return self.title
    }

    func getDate() -> String {
        return self.date
    }

    func getReceiptKind() -> ReceiptType {
        return self.receiptKind
    }
}
