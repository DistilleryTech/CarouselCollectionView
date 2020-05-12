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
    var itemSize: CGSize { get set }

    // Layout methods
    func visibleIndices(inFrame: CGRect, selectedIndex: Int) -> Range<Int>
    func calculateGeometryAttributes(atIndex: Int, selectedIndex: Int, dragOffset: CGPoint, parentFrame: CGRect) -> GeometryAttributes
}
