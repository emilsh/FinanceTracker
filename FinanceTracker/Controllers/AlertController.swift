//
//  AlertController.swift
//  FinanceTracker
//
//  Created by Raul Shafigin on 01.04.2022.
//

import UIKit

extension UIAlertController {
    enum Actions {
        case ok
        case cancel
    }
    static func requiredFieldsAlert(with message: String) -> UIAlertController {
        UIAlertController(title: "Please fill in required fields", message: message, preferredStyle: .alert)
    }
    
    func action(action: Actions) {
        switch action {
        case Actions.ok:
            let okAction = UIAlertAction(title: "Ok", style: .default)
            addAction(okAction)
            
        case Actions.cancel:
            let cancelAction = UIAlertAction(title: "Cancel", style: .destructive)
            addAction(cancelAction)
        }
    }
}
