//
//  UIViewController+Extensions.swift
//  DiscourseProject
//
//  Created by Gustavo A Ramírez Franco on 13/1/21.
//

import UIKit

extension UIViewController {
    
    func showAlert(_ alertMessage: String, alertTitle: String = NSLocalizedString("Error", comment: ""), _ alertActionTitle: String = NSLocalizedString("OK", comment: "")) {
        
        let alertController = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: alertActionTitle, style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
}
