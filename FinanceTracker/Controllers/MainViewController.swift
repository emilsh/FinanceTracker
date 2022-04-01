//
//  ViewController.swift
//  FinanceTracker
//
//  Created by Emil Shafigin on 1/4/22.
//

import UIKit
import CoreData

class MainViewController: UIViewController {
  
  @IBOutlet weak var tableView: UITableView!
  
  var expenses: [Expense]!

  override func viewDidLoad() {
    super.viewDidLoad()
    
    expenses = FTManager.shared.fetchExpenses()
  }
  
}

extension MainViewController: UITableViewDataSource, UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return expenses.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "ExpenseCellId", for: indexPath) as? ExpenseCell else { return UITableViewCell() }
    let expense = expenses[indexPath.row]
    cell.configureCell(with: expense)
    
    return cell
  }
  
}

