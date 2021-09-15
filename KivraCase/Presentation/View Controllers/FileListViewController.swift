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

    @IBOutlet private var fileListTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.fileManager.requestFiles {
            print("All files requested... refreshing UI")
            DispatchQueue.main.async {
                self.fileListTableView.reloadData()
            }

        }

    }


}

// MARK: - UITableViewDelegate Extension
extension FileListViewController: UITableViewDelegate {}

// MARK: - UITableViewDataSource Extension
extension FileListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.fileManager.count()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if let cellType = self.fileManager.typeOfFileAt(index: indexPath.row) {

            switch cellType {
            case .Document:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: DocumentTableViewCell.self), for: indexPath) as? DocumentTableViewCell
                else { return UITableViewCell() }
                if let file = self.fileManager.fileAt(index: indexPath.row) as? DocumentProtocol {
                    cell.configure(from: file)
                    return cell
                } else {
                    return UITableViewCell()
                }
            case .Receipt:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ReceiptTableViewCell.self), for: indexPath) as? ReceiptTableViewCell
                else { return UITableViewCell() }
                if let file = self.fileManager.fileAt(index: indexPath.row) as? ReceiptProtocol {
                    cell.configure(from: file)
                    return cell
                } else {
                    return UITableViewCell()
                }
            }
        } else {
            return UITableViewCell()
        }
    }


}

