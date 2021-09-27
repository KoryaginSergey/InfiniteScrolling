//
//  Result.swift
//  InfiniteScrolling
//
//  Created by macuser on 27.09.2021.
//

import Foundation


enum Result<T, Error> {
  case success(T)
//  case failure(T)
  case failure(Error)
}
