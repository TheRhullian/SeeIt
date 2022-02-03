//
//  UIImage+Extension.swift
//  SeeIt
//
//  Created by Rhullian Damião on 02/02/22.
//

import Foundation
import UIKit

extension UIImage {
    static func getImage(from urlString: String) -> UIImage? {
        if let url = URL(string: urlString), let data = try? Data(contentsOf: url) {
            return UIImage(data: data)
        }
        return nil
    }
}
