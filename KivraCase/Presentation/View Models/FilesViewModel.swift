//
//  FilesViewModel.swift
//  KivraCase
//
//  Created by Jose Bolivar on 15/9/21.
//

import Foundation

protocol FileControllerProtocol {
    func requestFiles(completion: @escaping () -> Void)
    func typeOfFileAt(index: Int) -> FileType?
    func fileAt(index: Int) -> FileItem?
    func count() -> Int
}

// Classify elements within our Datasource
enum FileType {
    case Document
    case Receipt
}

// Main view model
class FileViewModel {

    // MARK: - Properties
    private var fileList: [FileItem] = []

    //Ideally this should be injected by a third party entity (i.e navigator, segue manager, etc...)
    private let documentManager: DocumentsControllerProtocol! = DocumentsViewModel()
    private let receiptManager: ReceiptsControllerProtocol! = ReceiptsViewModel()

}

// MARK: - FileControllerProtocol extension
extension FileViewModel: FileControllerProtocol {

    func fileAt(index: Int) -> FileItem? {
        if index < self.fileList.count {
            return self.fileList[index]
        } else {
            print("Error: file index out of bounds.")
            return .none
        }

    }

    func typeOfFileAt(index: Int) -> FileType? {
        if self.fileList[index] is Document {
            return .Document
        } else if self.fileList[index] is Receipt {
            return .Receipt
        } else {
            return .none
        }
    }

    func count() -> Int {
        return self.fileList.count
    }

    // Request documents and receipts, and finish once both request finish
    func requestFiles(completion: @escaping () -> Void) {

        // We use operation queues to manage both async requests, and the finish condition
        let operationQueue = OperationQueue()
        let documentRequest = BlockOperation {
            self.documentManager.requestDocuments { documentList in
                if let documentList = documentList {
                    for document in documentList {
                        self.fileList.append(document)
                    }
                }
                print("Documents requests finished.")
            }
        }
        let receiptRequest = BlockOperation {
            self.receiptManager.requestReceipts { receiptList in
                if let receiptList = receiptList {
                    for receipt in receiptList {
                        self.fileList.append(receipt)
                    }
                }
                print("Receipt requests finished.")
             }
        }
        let requestFinished = BlockOperation {
            print("All requests finished.")
            completion()
        }
        requestFinished.addDependency(documentRequest)
        requestFinished.addDependency(receiptRequest)

        operationQueue.addOperations([documentRequest, receiptRequest, requestFinished], waitUntilFinished: false)
    }

}
