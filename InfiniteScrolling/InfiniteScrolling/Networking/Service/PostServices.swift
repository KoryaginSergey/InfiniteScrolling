//
//  PostServices.swift
//  InfiniteScrolling
//
//  Created by macuser on 27.09.2021.
//

import Foundation

public struct Page {
   var size: Int
   var page: Int
   
   func getParameters() -> HTTPParameters {
     ["pageSize": size,
      "page" : page]
   }
 }


struct PostServices{

  static let shared = PostServices()
  let postSession = URLSession(configuration: .default)
  
  func getPosts(page: Page, _ completion: @escaping (Result<ModelArticle>) -> ()) {
    do{
      let request = try HTTPNetworkRequest.configureHTTPRequest(from: .none, with: page.getParameters(), includes: .none, contains: nil, and: .get)

      postSession.dataTask(with: request) { (data, res, err) in

        if let response = res as? HTTPURLResponse, let unwrappedData = data {

          let result = HTTPNetworkResponse.handleNetworkResponse(for: response)
          switch result {

          case .success:
            let result = try? JSONDecoder().decode(ModelArticle.self, from: unwrappedData)
            completion(Result.success(result!))
            print(result)
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
