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
  
  weak var delegate: AddExpenseVCDelegate?
    var expense: Expense?
    var index: Int?
  
  override func viewDidLoad() {
        super.viewDidLoad()
        configureEditedParams()
        // Do any additional setup after loading the view.
    }
    

  //MARK: - Actions
    
  @IBAction func cancelButtonTapped(_ sender: Any) {
    dismiss(animated: true)
  }
  
  @IBAction func saveButtonTapped(_ sender: Any) {
    guard let category = categoryTF.text, !category.isEmpty else {
      //show alert
        addRedLineToTF(textfield: categoryTF)
        showAlert(with: "Field 'Category' is required")

      return
    }
    
    guard let cost = costTF.text, !cost.isEmpty, let costValue = Double(cost) else {
      //show alert
        showAlert(with: "Field 'cost' is required")
      return
    }
    
      guard let expense = expense else {
          saveNewExpense(category: category, cost: costValue, comment: commentTF.text ?? "")
          dismiss(animated: true)
          return
      }
      
      saveEditedExpense(expense: expense, category: category, cost: costValue, comment: commentTF.text ?? "")
      dismiss(animated: true)
  }
}

extension AddExpenseVC {
    private func showAlert(with text: String) {
        let alert = UIAlertController.requiredFieldsAlert(with: text)
        alert.action(action: UIAlertController.Actions.ok)
        present(alert, animated: true)
    }
    
    private func addRedLineToTF(textfield: UITextField) {
        textfield.layer.borderWidth = 0.8
        textfield.layer.borderColor = UIColor.red.cgColor
        //textfield.placeholder = "Required field"
        textfield.attributedPlaceholder = NSAttributedString (
            string: "required field",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.red]
        )
    }
    
    private func configureEditedParams() {
        guard let expense = expense else { return }
        categoryTF.text = expense.category
        commentTF.text = expense.comment
        costTF.text = "\(expense.cost)"
    }
    
    private func saveNewExpense(category: String, cost: Double, comment: String) {
        let expense = FTManager.shared.saveExpense(category: category, cost: cost, comment: comment)
        delegate?.expenseSaved(expense)
    }
    
    private func saveEditedExpense(expense: Expense, category: String, cost: Double, comment: String) {
        guard let index = index else { return }
        FTManager.shared.editExpense(expense, editedCategory: category, editedCost: cost, editedComment: comment)
        delegate?.expenseEdited(expense, index: index)
    }
}

protocol AddExpenseVCDelegate: AnyObject {
  func expenseSaved(_ expense: Expense)
  func expenseEdited(_ expense: Expense, index: Int)
}
