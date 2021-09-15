//
//  Document.swift
//  KivraCase
//
//  Created by Jose Bolivar on 15/9/21.
//

import Foundation

protocol DocumentProtocol {

}

// By abstracting the Document into a protocol we ensure the whole object is not shared,
// only the protocol with the functions to read or write, which is way safer.
struct Document: FileItem, Codable {

    internal var title: String
    internal var date: String
//    internal var logo: String       // This could be a URL returned from the API, for now its
    private var subtitle: String

    enum CodingKeys: String, CodingKey {
        case title = "subject"
        case subtitle = "sender_name"
        case date = "created_at"
    }

}


// MARK: - DocumentProtocol Extension
extension Document: DocumentProtocol {

}
