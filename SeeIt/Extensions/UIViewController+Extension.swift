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
    
    func fullScreenLoading(hide: Bool, height: CGFloat? = nil) {
        let tag = 101
        if hide {
            for views in self.view.subviews where views.tag == tag {
                for activity in views.subviews where activity is UIActivityIndicatorView {
                    views.removeFromSuperview()
                }
            }
        } else {
            let screenSize = UIScreen.main.bounds
            let screenWidth = screenSize.width
            let screenHeight = height ?? screenSize.height
            let view = UIView.init(frame: CGRect.init(x: 0.0, y: 0.0, width: screenWidth, height: screenHeight))
            view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
            view.tag = tag
            
            let activityIndicator = UIActivityIndicatorView()
            activityIndicator.style = .medium
            activityIndicator.color = .darkGray
            activityIndicator.startAnimating()
            view.addSubview(activityIndicator)
            
            activityIndicator.center = view.center
            
            self.view.addSubview(view)
        }
    }
}
