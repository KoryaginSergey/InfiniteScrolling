//
//  CDTopModel+CoreDataProperties.swift
//  InfiniteScrolling
//
//  Created by Admin on 08.11.2021.
//
//

import Foundation
import CoreData


extension CDTopModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDTopModel> {
        return NSFetchRequest<CDTopModel>(entityName: "CDTopModel")
    }


}
