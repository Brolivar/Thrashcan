//
//  DocumentTableViewCell.swift
//  KivraCase
//
//  Created by Jose Bolivar on 15/9/21.
//

import UIKit

class DocumentTableViewCell: UITableViewCell {
    // MARK: - Properties
//    @IBOutlet private var logoImageView: UIImageView!         // We don't need the outlet since its static from IB
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var dateLabel: UILabel!
    @IBOutlet private var subtitleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configure(from document: DocumentProtocol) {
        self.titleLabel.text = document.title
        self.subtitleLabel.text = document.getSubtitle()

        let dateFormatter = DateFormatter()
        // Change to a more readable format
        if let date = dateFormatter.dateFromMultipleFormats(fromString: document.date) {
            dateFormatter.dateFormat = "d MMM yyyy"
            dateFormatter.string(from: date)
            self.dateLabel.text = dateFormatter.string(from: date)
        } else {
            print("Error formating the date.")
        }
    }
    // Reset the table cells as if it were new
    override func prepareForReuse() {
        self.resetToDetault()
    }

    private func resetToDetault() {
        self.dateLabel.text = ""
        self.titleLabel.text = ""
        self.subtitleLabel.text = ""
    }

}
