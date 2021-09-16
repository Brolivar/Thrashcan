//
//  FileItem.swift
//  KivraCase
//
//  Created by Jose Bolivar on 15/9/21.
//

import Foundation

// Abstract the parts that are common between both Document and Receipt into a protocol that we make both types conform to,
// So we can iterate them together regardless of type
protocol FileItem {
    var title: String { get }
    var date: String { get }
}
