//
//  UIColor+Random.swift
//  CarouselCollectionViewExample
//
//  Created by Denis Shalagin on 21.02.2020.
//  Copyright © 2020 Distillery. All rights reserved.
//

import UIKit

extension UIColor {
    static var randomColor: UIColor {
        return UIColor(red: .random(in: 0...1),
                       green: .random(in: 0...1),
                       blue: .random(in: 0...1),
                       alpha: 1.0)
    }
}
