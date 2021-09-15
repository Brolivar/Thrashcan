//
//  NetworkManager.swift
//  KivraCase
//
//  Created by Jose Bolivar on 15/9/21.
//

import Foundation


protocol NetworkControllerProtocol: AnyObject {
    func downloadDocumentData(completion: @escaping (Result<[Document], NetworkError>) -> Void)
}

// Error tracking for the API request:
// On a real scenario, more errors would be used/added, for better accuracy tracking
enum NetworkError: Error {
    case requestError
    case timeoutError
    case decodingError
}

class NetworkManager {}

extension NetworkManager: NetworkControllerProtocol {
    func downloadDocumentData(completion: @escaping (Result<[Document], NetworkError>) -> Void) {

        // On a real scenario here we would use URLSession datatask
        let bundle = Bundle(for: type(of: self))
        guard let url = bundle.url(forResource: "Documents", withExtension: "json") else {
            completion(.failure(.requestError))
            return
        }

        do {
            let responseData = try Data(contentsOf: url)
            let documentList = try JSONDecoder().decode([Document].self, from: responseData)

            if !documentList.isEmpty {
                completion(.success(documentList))
            } else {
                completion(.failure(.decodingError))
            }
        } catch {
            completion(.failure(.decodingError))
        }

    }

}
