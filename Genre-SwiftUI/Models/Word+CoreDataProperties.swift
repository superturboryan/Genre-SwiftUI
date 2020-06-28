//
//  Word+CoreDataProperties.swift
//  Genre
//
//  Created by Ryan David Forsyth on 2019-11-03.
//  Copyright © 2019 Ryan F. All rights reserved.
//
//

import Foundation
import CoreData


extension Word {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Word> {
        return NSFetchRequest<Word>(entityName: "Word")
    }

    @NSManaged public var correctCount: Int32
    @NSManaged public var gender: Bool
    @NSManaged public var hint: String?
    @NSManaged public var incorrectCount: Int32
    @NSManaged public var word: String?
    @NSManaged public var favourite: Bool

}
