//
//  HTTPNetworkRequest.swift
//  InfiniteScrolling
//
//  Created by macuser on 27.09.2021.
//

import Foundation


public typealias HTTPParameters = [String: Any]?
public typealias HTTPHeaders = [String: Any]?

//let defaultParams: HTTPParameters = ["apiKey" : "97777613713c49a48689879ed89eaeb3"]
let defaultParams: HTTPParameters = ["apiKey" : "cda59155c15044a5adadfb5c96323dbe"]


struct HTTPNetworkRequest {
  
  /// Set the body, method, headers, and paramaters of the request
  static func configureHTTPRequest(with parameters: HTTPParameters, includes headers: HTTPHeaders, contains body: Data?, and method: HTTPMethod, endpoint: String) throws -> URLRequest {
    
    guard let url = URL(string: "https://newsapi.org/v2\(endpoint)") else { throw HTTPNetworkError.missingURL}
    
    var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10.0)
    
    request.httpMethod = method.rawValue
    request.httpBody = body
    var params = defaultParams
    params?.merge(parameters ?? [:]){(current, _) in current}
    try configureParametersAndHeaders(parameters: params, headers: headers, request: &request)
    
    return request
  }
  
  /// Configure the request parameters and headers before the API Call
  static func configureParametersAndHeaders(parameters: HTTPParameters?,
                                            headers: HTTPHeaders?,
                                            request: inout URLRequest) throws {
    do {
      if let headers = headers, let parameters = parameters {
        try URLEncoder.encodeParameters(for: &request, with: parameters)
        try URLEncoder.setHeaders(for: &request, with: headers)
      }
    } catch {
      throw HTTPNetworkError.encodingFailed
    }
  }
}
