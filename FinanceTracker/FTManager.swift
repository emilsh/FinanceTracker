//
//  FTManager.swift
//  FinanceTracker
//
//  Created by Emil Shafigin on 1/4/22.
//

import Foundation
import CoreData

class FTManager {
  static let shared = FTManager()
  private init() {}
  
  let coreDataStack = CoreDataStack(modelName: "FinanceTracker")
  
  func fetchExpenses() -> [Expense] {
    
    let expensesFetch: NSFetchRequest<Expense> = Expense.fetchRequest()
    
    do {
      let results = try coreDataStack.managedContext.fetch(expensesFetch)
      if results.isEmpty {
        return []
      } else {
        return results
      }
    } catch let error as NSError {
      print("Fetch error: \(error) description: \(error.userInfo)")
    }
    return []
  }
  
  func saveExpense(category: String, cost: Double, comment: String = "") -> Expense {
        
    let expense = Expense(context: coreDataStack.managedContext)
    expense.category = category
    expense.date = Date()
    expense.comment = comment
    expense.cost = cost
    
    coreDataStack.saveContext()
    return expense
  }
}
