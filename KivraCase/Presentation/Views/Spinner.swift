//
//  Spinner.swift
//  KivraCase
//
//  Created by Jose Bolivar on 16/9/21.
//

import UIKit

class Spinner: UIView {
    // MARK: - Properties
    @IBOutlet private var contentView: UIView!
    @IBOutlet private var spinner: UIActivityIndicatorView!
    private var nibName = "Spinner"

    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.loadFromNib()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.loadFromNib()
    }

    private func loadFromNib() {
        Bundle.main.loadNibNamed(self.nibName, owner: self, options: nil)
        self.addSubview(self.contentView)
        self.contentView.constraintsFillView(self)
    }

    func startAnimating() {
        self.spinner.startAnimating()
    }

    func stopAnimating() {
        self.spinner.stopAnimating()
    }
}
