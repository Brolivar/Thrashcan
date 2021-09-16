//
//  ReceiptsViewModel.swift
//  KivraCase
//
//  Created by Jose Bolivar on 15/9/21.
//

import Foundation


// Privacy is accomplished by injecting an abstraction     // 'ReceiptsControllerProtocol' rather of a type 'ReceiptsViewModel'
protocol ReceiptsControllerProtocol {
    func requestReceipts(completion: @escaping ([ReceiptProtocol]?) -> Void)
}

class ReceiptsViewModel {
    // MARK: - Properties
    private var receipts: [ReceiptProtocol] = []
    private var networkManager: NetworkControllerProtocol = NetworkManager()

}

// MARK: - ReceiptsControllerProtocol extension
extension ReceiptsViewModel: ReceiptsControllerProtocol {
    func requestReceipts(completion: @escaping ([ReceiptProtocol]?) -> Void) {
        self.networkManager.downloadReceiptData { [weak self] result in
            guard let `self` = self else { return }
            switch result {
                case .success(let receiptsList):
                    print("Receipts request successfully")
                    self.receipts = receiptsList
                    completion(receiptsList)
                 case .failure(let error):
                    print("Receipts request failed: ", error)
                    completion(.none)
                }
            }
    }

}

