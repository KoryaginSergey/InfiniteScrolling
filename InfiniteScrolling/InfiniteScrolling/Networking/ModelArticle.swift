//
//  ModelNews.swift
//  InfiniteScrolling
//
//  Created by macuser on 24.09.2021.
//

import Foundation


struct ModelArticle: Codable {
  let source: Source?
  let title: String?
  let url: URL?
  let urlToImage: URL?
  let publishedAt: String?
  let content: String?
}

struct Source: Codable {
  let id: String?
  let name: String?
}
