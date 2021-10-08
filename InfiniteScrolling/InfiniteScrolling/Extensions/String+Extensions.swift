//
//  String+Extensions.swift
//  InfiniteScrolling
//
//  Created by macuser on 06.10.2021.
//

import Foundation


extension String {
  
  func mmm_dd_yyyy() -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
    dateFormatter.locale = Locale(identifier: "en_US_POSIX")
    let date = dateFormatter.date(from: self)
    dateFormatter.dateFormat = "MMM dd, yyyy"
    let valueDate = dateFormatter.string(from: date!)
    return valueDate
  }
  
  func mmmm_dd_yyyy() -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
    dateFormatter.locale = Locale(identifier: "en_US_POSIX")
    let date = dateFormatter.date(from: self)
    dateFormatter.dateFormat = "MMMM dd, yyyy"
    let valueDate = dateFormatter.string(from: date!)
    return valueDate
  }
}

