//
//  HTTPURLResponse.swift
//  InfiniteScrolling
//
//  Created by macuser on 06.10.2021.
//

import Foundation


extension HTTPURLResponse {
  var hasSuccessStatusCode: Bool {
    return 200...299 ~= statusCode
  }
}
