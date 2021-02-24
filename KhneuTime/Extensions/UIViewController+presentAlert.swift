//
//  UIViewController+presentAlert.swift
//  KhneuTime
//
//  Created by Kyrylo Chernov on 11.10.2020.
//

import UIKit

extension UIViewController {
    
    func presentAlert(withTitle title: String, message : String, actions: [String], callback: ((String)->Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        for action in actions {
            let alertAction = UIAlertAction(title: action, style: .default) { _ in
                callback?(action)
            }
            alertController.addAction(alertAction)
        }
        self.present(alertController, animated: true, completion: nil)
    }
}
