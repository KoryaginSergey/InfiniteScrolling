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
  
  private let listEverythingURL = URL(string: "https://newsapi.org/v2/everything?domains=techcrunch.com,thenextweb.com&apiKey=97777613713c49a48689879ed89eaeb3")!
  
  
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
  
//  func getListOfCities(by cityName: String, result: @escaping (([CityModel]?)->())) -> URLSessionDataTask? {
//      guard let url = URL(string: WeatherURL.direct(name: cityName).url) else {
//          result(nil)
//          return nil
//      }
//      let task = URLSession.shared.dataTask(with: url) { (data, responce, error) in
//          DispatchQueue.main.async {
//              guard  error == nil else {
//                  print("error: ",error?.localizedDescription as Any)
//                  return
//              }
//              result(self.decodejson(type: [CityModel].self , from: data))
//          }
//      }
//      task.resume()
//      return task
//  }
//  
  func apiToGetEverythingList(completion : @escaping (ModelArticle) -> ()){
          URLSession.shared.dataTask(with: listEverythingURL) { (data, urlResponse, error) in
              if let data = data {
                  
                  let jsonDecoder = JSONDecoder()
                  
                  let articleData = try! jsonDecoder.decode(ModelArticle.self, from: data)
                      completion(articleData)
                print(articleData)
              }
          }.resume()
      }
  
  
  
  
}
