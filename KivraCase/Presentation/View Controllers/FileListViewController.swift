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

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.fileManager.requestDocuments { status in
        
        }
    }


}

