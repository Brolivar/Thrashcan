//
//  NetworkManager.swift
//  KivraCase
//
//  Created by Jose Bolivar on 15/9/21.
//

import Foundation


protocol NetworkControllerProtocol: AnyObject {
    func downloadDocumentData(completion: @escaping (Result<[DocumentProtocol], NetworkError>) -> Void)
    func downloadReceiptData(completion: @escaping (Result<[ReceiptProtocol], NetworkError>) -> Void)
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
    func downloadDocumentData(completion: @escaping (Result<[DocumentProtocol], NetworkError>) -> Void) {
        var documentList: [DocumentProtocol] = []
        // On a real scenario here we would use URLSession datatask
        let bundle = Bundle(for: type(of: self))
        guard let url = bundle.url(forResource: "Documents", withExtension: "json") else {
            completion(.failure(.requestError))
            return
        }
        do {
            let responseData = try Data(contentsOf: url)
            documentList = try JSONDecoder().decode([Document].self, from: responseData)

            if documentList.isEmpty {   // Empty response
                completion(.success(documentList))
            } else {
                completion(.success(documentList))
            }
        } catch {
            completion(.failure(.decodingError))
        }
    }

    func downloadReceiptData(completion: @escaping (Result<[ReceiptProtocol], NetworkError>) -> Void) {
        var receiptList: [Receipt] = []
        // On a real scenario here we would use URLSession datatask
        let bundle = Bundle(for: type(of: self))
        guard let url = bundle.url(forResource: "Receipts", withExtension: "json") else {
            completion(.failure(.requestError))
            return
        }
        do {
            let responseData = try Data(contentsOf: url)
            let decodedResponse = try JSONDecoder().decode(APIReceiptResponse.self, from: responseData)
            if decodedResponse.resultsNumber > 0 {
                for receipt in decodedResponse.receiptList {

                    var type: ReceiptType
                    switch receipt.receiptKind {
                    case "SALE":
                        type = .sale
                    case "RETURN":
                        type = .returnType
                    default:
                        type = .sale        // We could add an 'undefined' type on the enum as well
                    }
                    let newReceipt = Receipt(title: receipt.title, date: receipt.date, receiptKind: type)
                    receiptList.append(newReceipt)
                }
                completion(.success(receiptList))
            } else {    // No receipts returned
                completion(.success(receiptList))
            }
        } catch {
            completion(.failure(.decodingError))
        }
    }
}
