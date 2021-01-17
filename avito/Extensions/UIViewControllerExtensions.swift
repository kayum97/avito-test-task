//
//  UIViewControllerExtensions.swift
//  avito
//
//  Created by Admin on 17.01.2021.
//

import Foundation
import UIKit

extension UIViewController {
    func showSimpleAlert(title: String?, message: String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
}
