//
//  FilesViewModel.swift
//  KivraCase
//
//  Created by Jose Bolivar on 15/9/21.
//

import Foundation

protocol FileControllerProtocol {
    func requestFiles(completion: @escaping () -> Void)
    func typeOfFileAt(indexSection: Int, indexRow: Int) -> FileType?
    func fileAt(indexSection: Int, indexRow: Int) -> FileItem?
    func count() -> Int
    func getSectionAt(_ index: Int) -> MonthSection
    func getNumberOfSections() -> Int
}

// Classify stored File elements in our ViewModel
enum FileType {
    case Document
    case Receipt
}

// In order to organize the files by month, we need to create different sections containing title and a list of files for that month
struct MonthSection {
    var title: String
    var files: [FileItem]
}

// Main view model
class FileViewModel {

    // MARK: - Properties
    private var fileList: [FileItem] = []
    private var fileSections: [MonthSection] = []


    //Ideally this should be injected by a third party entity (i.e navigator, segue manager, etc...)
    private let documentManager: DocumentsControllerProtocol! = DocumentsViewModel()
    private let receiptManager: ReceiptsControllerProtocol! = ReceiptsViewModel()

    // Groups and sorts the File list by date.
    private func groupFilesByDate() {
        // We get the dictionary of grouped -> date: [FileItems]
        let groupedDictionary = self.groupedFilesByMonth()

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM yyyy"
        dateFormatter.timeZone = .current
        // Now we sort it by key (oldest date first)
        let sortedDictionary = groupedDictionary.sorted(by: { $0.key < $1.key })


        // Once grouped and sorted, it is ready to be presented on the tableview
        let sections = sortedDictionary.map { MonthSection(title: dateFormatter.string(from: $0.key), files: $0.value) }
        self.fileSections = sections
    }

    // Retrieve a grouped by date dictionary from our files array
    private func groupedFilesByMonth() -> [Date: [FileItem]] {

        let groupedDictionary: [Date: [FileItem]] = [:]
        return self.fileList.reduce(into: groupedDictionary) { acc, cur in

            let dateFormatter = DateFormatter()
            if let formattedDate = dateFormatter.dateFromMultipleFormats(fromString: cur.date) {
                let components = Calendar.current.dateComponents([.year, .month], from: formattedDate)      // Components to compare date with each other
                // We account existing or new cases
                if let date = Calendar.current.date(from: components) {
                    let existing = acc[date] ?? []
                    acc[date] = existing + [cur]
                }
            }
        }
    }
}

// MARK: - FileControllerProtocol extension
extension FileViewModel: FileControllerProtocol {

    func fileAt(indexSection: Int, indexRow: Int) -> FileItem? {
        if (indexSection < self.fileList.count) && (indexRow < self.fileSections[indexSection].files.count) {
            return self.fileSections[indexSection].files[indexRow]
        } else {
            print("Error: file index out of bounds.")
            return .none
        }

    }

    func typeOfFileAt(indexSection: Int, indexRow: Int) -> FileType? {
        if self.fileSections[indexSection].files[indexRow] is Document {
            return .Document
        } else if self.fileSections[indexSection].files[indexRow] is Receipt {
            return .Receipt
        } else {
            return .none
        }
    }

    func count() -> Int {
        return self.fileList.count
    }

    func getSectionAt(_ index: Int) -> MonthSection {
        return self.fileSections[index]
    }

    func getNumberOfSections() -> Int {
        return self.fileSections.count
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
            self.groupFilesByDate()
            completion()
        }
        requestFinished.addDependency(documentRequest)
        requestFinished.addDependency(receiptRequest)

        operationQueue.addOperations([documentRequest, receiptRequest, requestFinished], waitUntilFinished: false)
    }

}
