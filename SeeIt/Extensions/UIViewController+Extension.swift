//
//  UIViewController+Extension.swift
//  SeeIt
//
//  Created by Rhullian Damião on 02/02/22.
//

import Foundation
import UIKit

extension UIViewController {
    static var activeTextfield: UITextField?
    
    func tapToDismiss() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        self.view.addGestureRecognizer(tap)
    }
    
    @objc func hideKeyboard() {
        UIViewController.activeTextfield?.resignFirstResponder()
    }
}
