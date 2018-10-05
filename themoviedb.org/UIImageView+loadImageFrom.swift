//
//  UIImageView+loadImageFrom.swift
//  themoviedb.org
//
//  Created by Nigel Barber on 05/10/2018.
//  Copyright © 2018 Nigel Barber. All rights reserved.
//

import Foundation
import UIKit

// Asynchronous image loading
//  - use view.tag as a unique key to ensure the loaded image matches the view after cell recycling
//  - assumes tag is not mutated elsewhere
//  - not enough time to implement async image decompression via ImageIO
//  - may get async decompression for free via view.layer.contents = image.CGImage
//  - can be expanded with placeholder images, retry logic, error handling etc.
extension UIImageView {
    func loadImageFrom(_ url: URL, tag: Int, completion: @escaping () -> Void) {
        self.tag = tag
        DispatchQueue.global(qos: .userInteractive).async { [load_tag = tag] in
            guard let imageData = try? Data(contentsOf: url) else { return }
            DispatchQueue.main.async {
                if (self.tag == load_tag) {
                    if let image = UIImage(data: imageData) {
                        self.image = image
                        completion()
                    }
                }
            }
        }
    }
}
