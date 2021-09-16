//
//  Document.swift
//  KivraCase
//
//  Created by Jose Bolivar on 15/9/21.
//

import Foundation

protocol DocumentProtocol: FileItem {
    func getSubtitle() -> String
}

// By abstracting the Document into a protocol we ensure the whole object is not shared,
// only the protocol with the functions to read or write, which is way safer.
struct Document: Codable {
    private var subject: String
    private var creationDate: String
//    private var logo: String       // This could be a URL returned from the API, but for now it's a static UI Symbol
    private var subtitle: String

    enum CodingKeys: String, CodingKey {
        case subject = "subject"
        case subtitle = "sender_name"
        case creationDate = "created_at"
    }
}

// MARK: - DocumentProtocol Extension
extension Document: DocumentProtocol {
    func getSubtitle() -> String {
        return self.subtitle
    }

    var title: String {
        return self.subject
    }

    var date: String {
        return self.creationDate
    }

}
