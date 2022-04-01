//
//  Expense+CoreDataProperties.swift
//  FinanceTracker
//
//  Created by Emil Shafigin on 1/4/22.
//
//

import Foundation
import CoreData


extension Expense {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Expense> {
        return NSFetchRequest<Expense>(entityName: "Expense")
    }

    @NSManaged public var cost: Double
    @NSManaged public var category: String?
    @NSManaged public var comment: String?
    @NSManaged public var date: Date?

}

extension Expense : Identifiable {

}
