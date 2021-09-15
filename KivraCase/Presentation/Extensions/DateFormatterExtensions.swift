//
//  DateFormatterExtensions.swift
//  KivraCase
//
//  Created by Jose Bolivar on 15/9/21.
//

import Foundation

// This extension was created due to Document.json having multiple date formats for the 'created_at',
// and so we use it to determine which is the correct one in each case
extension DateFormatter {

    func dateFromMultipleFormats(fromString dateString: String) -> Date? {
        let formats: [String] = [
        "yyyy'-'MM'-'dd'T'HH':'mm':'ssZZZ",
        "yyyy'-'MM'-'dd'",
        ]
    for format in formats {
        self.dateFormat = format
        if let date = self.date(from: dateString) {
                return date
            }
        }
        return nil
    }
}
