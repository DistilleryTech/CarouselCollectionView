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
    var padding: CGFloat { get }
    var verticalAlignment: VerticalAlignment { get }
    
    // Builder functions
    func itemSize(width: CGFloat, height: CGFloat) -> CarouselLayout
    func padding(_ padding: CGFloat) -> CarouselLayout
    func verticalAlignment(_ alignment: VerticalAlignment) -> CarouselLayout
    
    // Layout methods
    func calculateFrame(forItemAtIndex index: Int, selectedIndex: Int, dragOffset: CGFloat, parentFrame: CGRect) -> CGRect
}
