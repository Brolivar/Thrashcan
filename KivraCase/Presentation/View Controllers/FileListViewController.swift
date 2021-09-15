//
//  FileListViewController.swift
//  KivraCase
//
//  Created by Jose Bolivar on 15/9/21.
//

import UIKit

class FileListViewController: UIViewController {

    // MARK: - Properties
    //Ideally this should be injected by a third party entity (i.e navigator, segue manager, etc...)
    var fileManager: DocumentsControllerProtocol! = DocumentsViewModel()
    var fileManager2: ReceiptsControllerProtocol! = ReceiptsViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        // ----- TEST -----
        // Do any additional setup after loading the view.
        self.fileManager.requestDocuments { status in

        }
        self.fileManager2.requestReceipts { status in

        }
    }


}

