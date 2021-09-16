//
//  UIView+Extensions.swift
//  KivraCase
//
//  Created by Jose Bolivar on 16/9/21.
//

import UIKit

extension UIView {
    func constraintsFillView(_ view: UIView, padding: UIEdgeInsets = .zero) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.topAnchor.constraint(equalTo: view.topAnchor, constant: padding.top).isActive = true
        self.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -padding.bottom).isActive = true
        self.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding.left).isActive = true
        self.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding.right).isActive = true
    }
}
