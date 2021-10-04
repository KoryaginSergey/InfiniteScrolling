//
//  HTTPNetworkRequest.swift
//  InfiniteScrolling
//
//  Created by macuser on 27.09.2021.
//

import Foundation


public typealias HTTPParameters = [String: Any]?
public typealias HTTPHeaders = [String: Any]?

let defaultParams: HTTPParameters = ["country" : "us",
                                     "apiKey" : "97777613713c49a48689879ed89eaeb3"]

struct HTTPNetworkRequest {
    
    /// Set the body, method, headers, and paramaters of the request
    static func configureHTTPRequest(from route: HTTPNetworkRoute, with parameters: HTTPParameters, includes headers: HTTPHeaders, contains body: Data?, and method: HTTPMethod) throws -> URLRequest {
        
        guard let url = URL(string: "https://newsapi.org/v2/top-headlines") else { throw HTTPNetworkError.missingURL}
        
        /*
                    *** NOTES ABOUT REQUEST ***
        
            * You can use the simple initializer if you'd like:
                  var request = URLRequest(url: url)
            * The timeoutInterval argument tells URLSession the amount of time(in seconds) to wait for a response from the server
            * When Making a GET request, we don't pass anything in the body
            * You can cmd+click on each method and parameter to learn more about them.
        */
        
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
