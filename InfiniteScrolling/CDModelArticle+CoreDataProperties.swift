//
//  CDModelArticle+CoreDataProperties.swift
//  InfiniteScrolling
//
//  Created by macuser on 10.11.2021.
//
//

import Foundation
import CoreData


extension CDModelArticle {
  
  @nonobjc public class func fetchRequest() -> NSFetchRequest<CDModelArticle> {
    return NSFetchRequest<CDModelArticle>(entityName: "CDModelArticle")
  }
  
  @NSManaged public var content: String?
  @NSManaged public var id: Int16
  @NSManaged public var nameSource: String?
  @NSManaged public var publishedAt: String?
  @NSManaged public var title: String?
  @NSManaged public var urlArticle: URL?
  @NSManaged public var urlToImage: URL?
  @NSManaged public var type: Int16
}

extension CDModelArticle : Identifiable {
  
  enum ArticleType: Int16 {
    case top
    case bottom
  }
  
  static func store(by id: Int16, type: ArticleType, object: Article) {
    let articleStore = article(by: id, type: type)
    articleStore.nameSource = object.source?.name
    articleStore.title = object.title
    articleStore.urlArticle = object.url
    articleStore.urlToImage = object.urlToImage
    articleStore.publishedAt = object.publishedAt
    articleStore.content = object.content
  }
  
  static func article(by id: Int16, type: ArticleType) -> CDModelArticle {
    let request: NSFetchRequest<CDModelArticle> = self.fetchRequest()
    request.predicate = NSPredicate(format: "id == %i AND type == %i", id, type.rawValue)
    
    let articles = try? DataModels.sharedInstance.context.fetch(request)
    
    guard let article = articles?.first else {
      let context = DataModels.sharedInstance.context
      guard let entity = NSEntityDescription.entity(forEntityName: String(describing: CDModelArticle.self), in: context) else {
        fatalError("Entity does not exist")
      }
      let object = CDModelArticle(entity: entity, insertInto: context)
      object.id = id
      object.type = type.rawValue
      return object
    }
    return article
  }
}
