//
//  ModelNews.swift
//  InfiniteScrolling
//
//  Created by macuser on 24.09.2021.
//

import Foundation
import UIKit


public struct ModelArticle: Codable {
  let status: String?
  let totalResults: Int?
  let articles: [Article]?
}

public struct Article: Codable {
  let source: Source?
  let author: String?
  let title: String?
  let description: String?
  let url: URL?
  let urlToImage: URL?
  let publishedAt: String?
  let content: String?
}

public struct Source: Codable {
  let id: String?
  let name: String?
}

public extension Article {
  struct Defaults {
    static let articlePlaceholder: UIImage? = UIImage(named: "news1")
  }
}
