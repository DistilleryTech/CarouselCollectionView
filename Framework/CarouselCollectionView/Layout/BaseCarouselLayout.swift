//
//  BaseCarouselLayout.swift
//  CarouselCollectionView
//
//  Created by Denis Shalagin on 20.02.2020.
//  Copyright © 2020 Distillery. All rights reserved.
//

import SwiftUI

open class BaseCarouselLayout: CarouselLayout {
    public var itemSize: CGSize = .zero
    
    public func itemSize(width: CGFloat, height: CGFloat) -> CarouselLayout {
        itemSize = CGSize(width: width, height: height)
        
        return self
    }
    
    public func calculateVisibleIndices(inFrame: CGRect, selectedIndex: Int) -> Range<Int> {
        return 0..<1
    }
    
    public func calculateGeometryAttributes(atIndex: Int, selectedIndex: Int, dragOffset: CGPoint, parentFrame: CGRect) -> GeometryAttributes {
        return GeometryAttributes(frame: .zero, opacity: 1.0, zIndex: 0, transform: ProjectionTransform())
    }
}
