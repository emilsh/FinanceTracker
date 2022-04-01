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
  
  override func viewDidLoad() {
        super.viewDidLoad()

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
    
    let expense = FTManager.shared.saveExpense(category: category, cost: costValue, comment: commentTF.text ?? "")
    delegate?.expenseSaved(expense)
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
}

protocol AddExpenseVCDelegate: AnyObject {
  func expenseSaved(_ expense: Expense)
}
