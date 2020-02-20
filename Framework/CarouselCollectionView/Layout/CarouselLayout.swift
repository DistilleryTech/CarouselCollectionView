//
//  CarouselLayout.swift
//  CarouselCollectionView
//
//  Created by Denis Shalagin on 20.02.2020.
//  Copyright © 2020 Distillery. All rights reserved.
//

import UIKit

public protocol CarouselLayout {
    // Configuration
    var itemSize: CGSize { get }
    var padding: CGFloat { get }
    
    // Builder functions
    func itemSize(_ size: CGSize) -> CarouselLayout
    func padding(_ padding: CGFloat) -> CarouselLayout
    
    // Layout methods
    func calculatePosition(forItemAtIndex index: Int, selectedIndex: Int, dragOffset: CGFloat, parentFrame: CGRect) -> CGPoint
}
