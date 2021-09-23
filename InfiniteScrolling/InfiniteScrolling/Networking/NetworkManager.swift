//
//  NetworkManager.swift
//  InfiniteScrolling
//
//  Created by macuser on 23.09.2021.
//

import Foundation

// https://newsapi.org/v2/top-headlines?country=us&apiKey=97777613713c49a48689879ed89eaeb3
// https://newsapi.org/v2/everything?domains=techcrunch.com,thenextweb.com&apiKey=97777613713c49a48689879ed89eaeb3





class NetworkManager {
  
  private init() {}
  static let shared: NetworkManager = NetworkManager()
  
  
  // MARK: - Universal decodable function
  
      func decodeJson<T:Decodable>(type: T.Type, from: Data?) -> T? {
          let decoder = JSONDecoder()
          guard let data = from else { return nil }
          do {
              let objects = try decoder.decode(type.self, from: data)
              return objects
          } catch let error {
              print("data has been not decoded : \(error.localizedDescription)")
              return nil
          }
      }
  
  
  
  
  
  
  
  
  
}
