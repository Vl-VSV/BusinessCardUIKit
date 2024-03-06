//
//  String+localized.swift
//  BusinessCardUIKit
//
//  Created by Vlad V on 05.03.2024.
//

import Foundation

extension String {
    var localized: String {
        NSLocalizedString(self, comment: "").replacingOccurrences(of: "\\n", with: "\n")
    }
}
