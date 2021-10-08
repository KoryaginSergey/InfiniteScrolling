//
//  Result.swift
//  InfiniteScrolling
//
//  Created by macuser on 27.09.2021.
//

import Foundation


enum Result<T> {
  case success(T)
  case failure(Error)
}
