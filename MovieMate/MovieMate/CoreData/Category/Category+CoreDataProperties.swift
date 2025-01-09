//
//  Category+CoreDataProperties.swift
//  MovieMate
//
//  Created by Farid Rustamov on 08.01.25.
//
//

import Foundation
import CoreData


extension Category {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Category> {
        return NSFetchRequest<Category>(entityName: "Category")
    }

    @NSManaged public var id: String?
    @NSManaged public var movieName: String?

}

extension Category : Identifiable {

}
