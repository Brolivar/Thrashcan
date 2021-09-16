//
//  ReceiptTableViewCell.swift
//  KivraCase
//
//  Created by Jose Bolivar on 15/9/21.
//

import UIKit

class ReceiptTableViewCell: UITableViewCell {

    // MARK: - Properties
    @IBOutlet private var typeLabel: UILabel!
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var dateLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    // Reset the table cells as if it were new
    override func prepareForReuse() {
        self.resetToDetault()
    }

    private func resetToDetault() {
        self.dateLabel.text = ""
        self.titleLabel.text = ""
        self.typeLabel.text = ""
        self.typeLabel.isHidden = true
    }

    func configure(from document: ReceiptProtocol) {
        self.titleLabel.text = document.title
        let dateFormatter = DateFormatter()
        // Change to a more readable format
        if let date = dateFormatter.dateFromMultipleFormats(fromString: document.date) {
            dateFormatter.dateFormat = "d MMM yyyy"
            dateFormatter.string(from: date)
            self.dateLabel.text = dateFormatter.string(from: date)
        } else {
            print("Error formating the date.")
        }

        switch document.getReceiptKind() {
        case .returnType:
            self.typeLabel.isHidden = false
            self.typeLabel.text = ReceiptType.returnType.typeLabel
            break
        case .sale:
            self.typeLabel.isHidden = true
            break
        }
    }
}
