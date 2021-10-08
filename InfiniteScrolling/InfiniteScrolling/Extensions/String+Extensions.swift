//
//  String+Extensions.swift
//  InfiniteScrolling
//
//  Created by macuser on 06.10.2021.
//

import Foundation


extension String {
  var localizedString: String {
    return NSLocalizedString(self, comment: "")
  }
  
  var html2String: String {
    guard let data = data(using: .utf8), let attributedString = try? NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil) else {
      return self
    }
    return attributedString.string
  }
  
  func convertToDate(from originalDate: String) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
    dateFormatter.locale = Locale(identifier: "en_US_POSIX")
    let date = dateFormatter.date(from: originalDate)
    dateFormatter.dateFormat = "MMMM dd, yyyy"
    let valueDate = dateFormatter.string(from: date!)
    return valueDate
  }
}

