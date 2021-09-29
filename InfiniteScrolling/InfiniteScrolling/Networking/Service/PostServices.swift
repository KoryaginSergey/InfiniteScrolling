//
//  PostServices.swift
//  InfiniteScrolling
//
//  Created by macuser on 27.09.2021.
//

import Foundation


struct PostServices{
  
  static let shared = PostServices()
  let postSession = URLSession(configuration: .default)
  let parameters = [ "YOUR_KEY": "YOUR_VALUES" ]
  // NOTE : NOT ALL Request requires parameters. You can pass nil in the configureHTTPRequest() method for the parameter argument.

  func getPosts(_ completion: @escaping (Result<[ModelArticle]>) -> ()) {

    do{
      let request = try HTTPNetworkRequest.configureHTTPRequest(from: .getAllPosts, with: .none, includes: .none, contains: .none, and: .get)

      postSession.dataTask(with: request) { (data, res, err) in

        if let response = res as? HTTPURLResponse, let unwrappedData = data {

          let result = HTTPNetworkResponse.handleNetworkResponse(for: response)
          switch result {

          case .success:
            let result = try? JSONDecoder().decode([ModelArticle].self, from: unwrappedData)
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
