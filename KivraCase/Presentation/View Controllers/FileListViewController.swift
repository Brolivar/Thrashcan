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
    private let loadingView = UIView()      // View used to contain the loading text & spinner
    private let spinner = UIActivityIndicatorView()
    private let loadingLabel = UILabel()    // Label on spinner
    @IBOutlet private var fileListTableView: UITableView!

    override func viewDidLoad() {

        super.viewDidLoad()
        self.setLoadingScreen()
        // Simulate a delay while also showing a loading spinner for 1.5 second, before retrieving
        // and presenting the list
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

        // Sets the view which contains the loading text and the spinner
        let width: CGFloat = 120
        let height: CGFloat = 30
        let x = (self.fileListTableView.frame.width / 2) - (width / 2)
        let y = (self.fileListTableView.frame.height / 2) - (height / 2) - (self.navigationController?.navigationBar.frame.height)!
        self.loadingView.frame = CGRect(x: x, y: y, width: width, height: height)

        // Sets loading text & spinner
        self.loadingLabel.textColor = .gray
        self.loadingLabel.textAlignment = .center
        self.loadingLabel.text = "Loading..."
        self.loadingLabel.frame = CGRect(x: 0, y: 0, width: 140, height: 30)

        self.spinner.style = .large
        self.spinner.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        self.spinner.startAnimating()

        // Adds text & spinner to the view
        self.loadingView.addSubview(spinner)
        self.loadingView.addSubview(loadingLabel)
        self.fileListTableView.addSubview(loadingView)
    }

    // Remove the activity indicator from the main view
    private func removeLoadingScreen() {

        // Hides and stops the text and the spinner
        self.spinner.stopAnimating()
        self.spinner.isHidden = true
        self.loadingLabel.isHidden = true
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

