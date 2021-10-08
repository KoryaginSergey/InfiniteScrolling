//
//  PostServices.swift
//  InfiniteScrolling
//
//  Created by macuser on 27.09.2021.
//

import Foundation
import SDWebImage


public struct Page {
  var size: Int
  var page: Int
  var isFull: Bool = false
  
  func getParameters() -> HTTPParameters {
    ["pageSize": size,
     "page" : page]
  }
}

struct PostServices{
  
  static let shared = PostServices()
  let postSession = URLSession(configuration: .default)
  
  func getTopPosts(page: Page, _ completion: @escaping (Result<ModelArticle>) -> ()) {
    var params: HTTPParameters = [ "country" : "us" ]
    let endPoint = "/top-headlines"
    
    do{
      params?.merge(page.getParameters() ?? [:]) {(current, _) in current}
      let request = try HTTPNetworkRequest.configureHTTPRequest(from: .none, with: params, includes: .none, contains: nil, and: .get, endpoint: endPoint)
      postSession.dataTask(with: request) { (data, res, err) in
        if let response = res as? HTTPURLResponse, let unwrappedData = data {
          let result = HTTPNetworkResponse.handleNetworkResponse(for: response)
          switch result {
          case .success:
            let result = try? JSONDecoder().decode(ModelArticle.self, from: unwrappedData)
            completion(Result.success(result!))
          case .failure:
            completion(Result.failure(HTTPNetworkError.decodingFailed))
          }
        }
      }.resume()
    }catch{
      completion(Result.failure(HTTPNetworkError.badRequest))
    }
  }
  
  func getBottomPosts(page: Page, _ completion: @escaping (Result<ModelArticle>) -> ()) {
    var params: HTTPParameters = [ "q" : "bitcoin" ]
    let endPoint = "/everything"
    
    do{
      params?.merge(page.getParameters() ?? [:]) {(current, _) in current}
      let request = try HTTPNetworkRequest.configureHTTPRequest(from: .none, with: params, includes: .none, contains: nil, and: .get, endpoint: endPoint)
      postSession.dataTask(with: request) { (data, res, err) in
        if let response = res as? HTTPURLResponse, let unwrappedData = data {
          let result = HTTPNetworkResponse.handleNetworkResponse(for: response)
          switch result {
          case .success:
            let result = try? JSONDecoder().decode(ModelArticle.self, from: unwrappedData)
            completion(Result.success(result!))
          case .failure:
            completion(Result.failure(HTTPNetworkError.decodingFailed))
          }
        }
      }.resume()
    }catch{
      completion(Result.failure(HTTPNetworkError.badRequest))
    }
  }
}
