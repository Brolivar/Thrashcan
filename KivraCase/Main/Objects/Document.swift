//
//  Document.swift
//  KivraCase
//
//  Created by Jose Bolivar on 15/9/21.
//

import Foundation

protocol DocumentProtocol {
    func getTitle() -> String
    func getDate() -> String
    func getSubtitle() -> String
}

// By abstracting the Document into a protocol we ensure the whole object is not shared,
// only the protocol with the functions to read or write, which is way safer.
struct Document: FileItem, Codable {

    internal var title: String      // declared internal because it matches a requirement in internal protoco
    internal var date: String
//    internal var logo: String       // This could be a URL returned from the API, but for now it's a static UI Symbol
    private var subtitle: String

    enum CodingKeys: String, CodingKey {
        case title = "subject"
        case subtitle = "sender_name"
        case date = "created_at"
    }

}


// MARK: - DocumentProtocol Extension
extension Document: DocumentProtocol {
    func getTitle() -> String {
        return self.title
    }

    func getDate() -> String {
        return self.date
    }

    func getSubtitle() -> String {
        return self.subtitle
    }
}
