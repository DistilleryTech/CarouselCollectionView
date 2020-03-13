//
//  CarouselLayout.swift
//  CarouselCollectionView
//
//  Created by Denis Shalagin on 20.02.2020.
//  Copyright © 2020 Distillery. All rights reserved.
//

import SwiftUI

public protocol CarouselLayout {
    // Configuration
    var itemSize: CGSize { get }
    
    // Builder functions
    func itemSize(width: CGFloat, height: CGFloat) -> CarouselLayout
    
    // Layout methods
    func calculateGeometryAttributes(atIndex: Int, selectedIndex: Int, dragOffset: CGPoint, parentFrame: CGRect) -> GeometryAttributes
}
