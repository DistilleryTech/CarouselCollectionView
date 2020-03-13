//
//  BaseCarouselLayout.swift
//  CarouselCollectionView
//
//  Created by Denis Shalagin on 20.02.2020.
//  Copyright © 2020 Distillery. All rights reserved.
//

import SwiftUI

class BaseCarouselLayout: CarouselLayout {
    var itemSize: CGSize = .zero
    
    func itemSize(width: CGFloat, height: CGFloat) -> CarouselLayout {
        itemSize = CGSize(width: width, height: height)
        
        return self
    }
    
    func calculateGeometryAttributes(atIndex: Int, selectedIndex: Int, dragOffset: CGPoint, parentFrame: CGRect) -> GeometryAttributes {
        return GeometryAttributes(frame: .zero, zIndex: 0, transform: ProjectionTransform())
    }
}
