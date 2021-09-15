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
    var fileManager: FileControllerProtocol! = FileViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.fileManager.requestFiles {
            
        }

    }


}

