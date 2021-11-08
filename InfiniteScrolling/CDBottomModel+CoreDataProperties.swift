//
//  CDBottomModel+CoreDataProperties.swift
//  InfiniteScrolling
//
//  Created by Admin on 08.11.2021.
//
//

import Foundation
import CoreData


extension CDBottomModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDBottomModel> {
        return NSFetchRequest<CDBottomModel>(entityName: "CDBottomModel")
    }


}
