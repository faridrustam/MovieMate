//
//  WatchList+CoreDataProperties.swift
//  MovieMate
//
//  Created by Farid Rustamov on 14.01.25.
//
//

import Foundation
import CoreData


extension WatchList {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WatchList> {
        return NSFetchRequest<WatchList>(entityName: "WatchList")
    }

    @NSManaged public var aboutMovie: String?
    @NSManaged public var bacgroundImage: String?
    @NSManaged public var categoryId: String?
    @NSManaged public var movieName: String?
    @NSManaged public var posterImage: String?
    @NSManaged public var rating: Double
    @NSManaged public var releaseDate: String?
    @NSManaged public var time: String?
    @NSManaged public var trailer: String?

}

extension WatchList : Identifiable {

}
