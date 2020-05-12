//
//  BaseCarouselLayout.swift
//  CarouselCollectionView
//
//  Created by Denis Shalagin on 20.02.2020.
//  Copyright © 2020 Distillery. All rights reserved.
//

import SwiftUI

public class BaseCarouselLayout: CarouselLayout {
    public var itemSize: CGSize = .zero
        
    public func itemSize(width: CGFloat, height: CGFloat) -> CarouselLayout {
        itemSize = CGSize(width: width, height: height)
        
        return self
    }
    
    public func calculateVisibleIndices(inFrame: CGRect, selectedIndex: Int) -> Range<Int> {
        fatalError(#function + " must be overridden")
    }
    
    public func calculateGeometryAttributes(atIndex: Int, selectedIndex: Int, dragOffset: CGPoint, parentFrame: CGRect) -> GeometryAttributes {
        fatalError(#function + " must be overridden")
    }
}
