//
//  ExpenseCell.swift
//  FinanceTracker
//
//  Created by Emil Shafigin on 1/4/22.
//

import UIKit

class ExpenseCell: UITableViewCell {

  @IBOutlet weak var categoryLabel: UILabel!
  @IBOutlet weak var commentLabel: UILabel!
  @IBOutlet weak var costLabel: UILabel!
  
  override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
  
  func configureCell(with expense: Expense) {
    categoryLabel.text = expense.category
    commentLabel.text = expense.comment
    costLabel.text = "\(expense.cost)"
  }

}
