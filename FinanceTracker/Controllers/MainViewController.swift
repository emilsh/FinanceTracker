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
        
        tableView.dataSource = self
        tableView.delegate = self
        
        expenses = FTManager.shared.fetchExpenses()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addExpenseSegueId" {
            guard let destination = segue.destination as? AddExpenseVC else { return }
            destination.delegate = self
            
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            destination.expense = expenses[indexPath.row]
            destination.index = indexPath.row
        }
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70.0
    }
    
    //MARK: Delete expense
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let expense = expenses[indexPath.row]
        
        if editingStyle == .delete {
            expenses.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            FTManager.shared.deleteExpense(expense: expense)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //tableView.deselectRow(at: indexPath, animated: true)
        //expense = expenses[indexPath.row]
        performSegue(withIdentifier: "addExpenseSegueId", sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension MainViewController: AddExpenseVCDelegate {
    func expenseSaved(_ expense: Expense) {
        expenses.append(expense)
        tableView.reloadData()
    }
    func expenseEdited(_ expense: Expense, index: Int) {
        expenses[index] = expense
        tableView.reloadData()
    }
}

