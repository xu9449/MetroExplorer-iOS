//
//  Extensions.swift
//  MetroExplorer
//
//  Created by 许科欣 on 12/3/18.
//  Copyright © 2018 KexinXu. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
