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
  
  func saveExpense(_ expense: Expense) {
        
    let iExpense = Expense(context: coreDataStack.managedContext)
    iExpense.category = expense.category
    iExpense.date = Date()
    iExpense.comment = expense.comment
    iExpense.cost = expense.cost
    
    coreDataStack.saveContext()
  }
}
