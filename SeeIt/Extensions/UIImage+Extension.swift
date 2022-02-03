//
//  UIImage+Extension.swift
//  SeeIt
//
//  Created by Rhullian Damião on 02/02/22.
//

import Foundation
import UIKit

extension UIImage {
    static func getImage(from urlString: String, completion: @escaping (UIImage?) -> Void) {
        DispatchQueue(label: "ImageLoad").async {
            if let image: UIImage = Cache.shared.value(for: urlString) {
                completion(image)
                return
            }
            
            if let url = URL(string: urlString), let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                Cache.shared.insert(value: image, key: urlString)
                completion(image)
                return
            }
            completion(nil)
        }

    }
}
