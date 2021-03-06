//
//  DocumentsViewModel.swift
//  KivraCase
//
//  Created by Jose Bolivar on 15/9/21.
//

import Foundation

// Privacy is accomplished by injecting an abstraction     // 'DocumentsControllerProtocol' rather of a type 'DocumentsViewModel'
protocol DocumentsControllerProtocol {
    func requestDocuments(completion: @escaping ([DocumentProtocol]?) -> Void)
}

class DocumentsViewModel {
    // MARK: - Properties
    private var documents: [DocumentProtocol] = []
    private var networkManager: NetworkControllerProtocol = NetworkManager()

}

// MARK: - DocumentsControllerProtocol extension
extension DocumentsViewModel: DocumentsControllerProtocol {
    func requestDocuments(completion: @escaping ([DocumentProtocol]?) -> Void) {
        self.networkManager.downloadDocumentData { [weak self] result in
            guard let `self` = self else { return }
            switch result {
                case .success(let documentList):
                    print("Documents request successfully")
                    self.documents = documentList
                    completion(documentList)
                 case .failure(let error):
                    print("Documents request failed: ", error)
                    completion(.none)
                }
            }
    }

}

