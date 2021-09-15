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
        return self.fileManager.getSectionAt(section).files.count
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return self.fileManager.getNumberOfSections()
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.fileManager.getSectionAt(section).title
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let indexRow = indexPath.row
        let indexSection = indexPath.section

        if let cellType = self.fileManager.typeOfFileAt(indexSection: indexSection, indexRow: indexRow) {
            switch cellType {
            case .Document:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: DocumentTableViewCell.self), for: indexPath) as? DocumentTableViewCell
                else { return UITableViewCell() }
                if let file = self.fileManager.fileAt(indexSection: indexSection, indexRow: indexRow) as? DocumentProtocol {
                    cell.configure(from: file)
                    return cell
                } else {
                    return UITableViewCell()
                }
            case .Receipt:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ReceiptTableViewCell.self), for: indexPath) as? ReceiptTableViewCell
                else { return UITableViewCell() }
                if let file = self.fileManager.fileAt(indexSection: indexSection, indexRow: indexRow) as? ReceiptProtocol {
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

