//
//  BaseCarouselLayout.swift
//  CarouselCollectionView
//
//  Created by Denis Shalagin on 20.02.2020.
//  Copyright © 2020 Distillery. All rights reserved.
//

import UIKit

class BaseCarouselLayout: CarouselLayout {
    var itemSize: CGSize = .zero
    var padding: CGFloat = 0
    
    func itemSize(_ itemSize: CGSize) -> CarouselLayout {
        self.itemSize = itemSize
        
        return self
    }
    
    func padding(_ padding: CGFloat) -> CarouselLayout {
        self.padding = padding
        
        return self
    }
    
    func calculatePosition(forItemAtIndex index: Int, selectedIndex: Int, dragOffset: CGFloat, parentFrame: CGRect) -> CGPoint {
        return .zero
    }
}
