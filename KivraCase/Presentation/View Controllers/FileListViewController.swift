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

    // MARK: - UI Properties
    private var loadingView: Spinner?    // View used to contain the loading text & spinner
    @IBOutlet private var fileListTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Simulate a delay while also showing a loading spinner for 1.5 second, before retrieving
        // and presenting the list
        self.setLoadingScreen()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.fileManager.requestFiles {
                print("All files requested... refreshing UI")
                DispatchQueue.main.async {
                    self.removeLoadingScreen()
                    self.fileListTableView.reloadData()
                }
            }
        }
    }

    // Set the activity indicator into the main view
    private func setLoadingScreen() {
        self.loadingView = Spinner()
        if let loadingView = self.loadingView {
            self.view.addSubview(loadingView)
            loadingView.translatesAutoresizingMaskIntoConstraints = false
            loadingView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
            loadingView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
            loadingView.heightAnchor.constraint(equalToConstant: 200).isActive = true
            loadingView.widthAnchor.constraint(equalToConstant: 200).isActive = true
            loadingView.startAnimating()
        }
    }

    // Remove the activity indicator from the main view
    private func removeLoadingScreen() {
        // Hides and stops the text and the spinner
        if let loadingView = self.loadingView {
            loadingView.stopAnimating()
            loadingView.isHidden = true
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

        if let fileType = self.fileManager.typeOfFileAt(indexSection: indexSection, indexRow: indexRow) {
            switch fileType {
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

