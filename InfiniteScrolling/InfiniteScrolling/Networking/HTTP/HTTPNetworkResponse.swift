//
//  HTTPNetworkResponse.swift
//  InfiniteScrolling
//
//  Created by macuser on 27.09.2021.
//

import Foundation


struct HTTPNetworkResponse {
  
  // Properly checks and handles the status code of the response
  static func handleNetworkResponse(for response: HTTPURLResponse?) -> Result<String, String>{
    
    guard let res = response else { return Result.failure(HTTPNetworkError.UnwrappingError.rawValue)}
    
    switch res.statusCode {
    case 200...299: return Result.success(HTTPNetworkError.success.rawValue)
    case 401: return Result.failure(HTTPNetworkError.authenticationError.rawValue)
    case 400...499: return Result.failure(HTTPNetworkError.badRequest.rawValue)
    case 500...599: return Result.failure(HTTPNetworkError.serverSideError.rawValue)
    default: return Result.failure(HTTPNetworkError.failed.rawValue)
    }
  }
}
