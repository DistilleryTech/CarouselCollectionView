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
    var padding: CGFloat = 0
    var verticalAlignment: VerticalAlignment = .center
    
    func itemSize(width: CGFloat, height: CGFloat) -> CarouselLayout {
        itemSize = CGSize(width: width, height: height)
        
        return self
    }
    
    func padding(_ padding: CGFloat) -> CarouselLayout {
        self.padding = padding
        
        return self
    }
    
    func verticalAlignment(_ verticalAlignment: VerticalAlignment) -> CarouselLayout {
        self.verticalAlignment = verticalAlignment
        
        return self
    }
    
    func calculateFrame(forItemAtIndex index: Int, selectedIndex: Int, dragOffset: CGFloat, parentFrame: CGRect) -> CGRect {
        return .zero
    }
}
