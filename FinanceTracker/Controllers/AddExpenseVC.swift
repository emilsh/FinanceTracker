//
//  AddExpenseVC.swift
//  FinanceTracker
//
//  Created by Emil Shafigin on 1/4/22.
//

import UIKit

class AddExpenseVC: UIViewController {

  @IBOutlet weak var categoryTF: UITextField!
  @IBOutlet weak var commentTF: UITextField!
  @IBOutlet weak var costTF: UITextField!
  
  override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

  //MARK: - Actions
  
  @IBAction func cancelButtonTapped(_ sender: Any) {
    
  }
  
  @IBAction func saveButtonTapped(_ sender: Any) {
    guard let category = categoryTF.text, !category.isEmpty else {
      //show alert
      return
    }
    
    guard let cost = costTF.text, !cost.isEmpty, let costValue = Double(cost) else {
      //show alert
      return
    }
    
    let expense = Expense()
    expense.category = category
    expense.cost = costValue
    FTManager.shared.saveExpense(expense)
    
    dismiss(animated: true)
    
    
  }
  
  

}
