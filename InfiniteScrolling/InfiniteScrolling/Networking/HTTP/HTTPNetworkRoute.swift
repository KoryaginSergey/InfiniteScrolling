//
//  HTTPNetworkRoute.swift
//  InfiniteScrolling
//
//  Created by macuser on 27.09.2021.
//

import Foundation


public enum HTTPNetworkRoute: String{
  case getAllPosts = "posts/all"
  case createPost = "posts/new"
  case editPost = "posts/:id/edit"
  case deletePost = "posts/:id"
}
