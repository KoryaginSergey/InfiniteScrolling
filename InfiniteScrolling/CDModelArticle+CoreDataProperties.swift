//
//  CDModelArticle+CoreDataProperties.swift
//  InfiniteScrolling
//
//  Created by macuser on 08.11.2021.
//
//

import Foundation
import CoreData


extension CDModelArticle {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDModelArticle> {
        return NSFetchRequest<CDModelArticle>(entityName: "CDModelArticle")
    }

    @NSManaged public var nameSource: String?
    @NSManaged public var title: String?
    @NSManaged public var urlArticle: URL?
    @NSManaged public var urlToImage: URL?
    @NSManaged public var publishedAt: String?
    @NSManaged public var content: String?

}

extension CDModelArticle : Identifiable {
  
  
//  static func getCity(by name: String?) -> CDCityModel? {
//      let context = DataModels.sharedInstance.context
//      let fetchRequest = NSFetchRequest<CDCityModel>(entityName: String(describing: CDCityModel.self))
//      if let name = name {
//          let predicate = NSPredicate(format: "name == %@", name)
//          fetchRequest.predicate = predicate
//      }
//      let cities = try? context.fetch(fetchRequest)
//
//      return cities?.first
//  }
//
//  static func objectNumber() -> Int {
//      let context = DataModels.sharedInstance.context
//      let fetchRequest = NSFetchRequest<CDCityModel>(entityName: String(describing: CDCityModel.self))
//      let cities = try? context.fetch(fetchRequest)
//
//      return cities?.count ?? 0
//  }

}
