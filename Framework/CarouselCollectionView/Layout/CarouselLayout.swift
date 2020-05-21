//
//  CarouselLayout.swift
//  CarouselCollectionView
//
//  Created by Denis Shalagin on 20.02.2020.
//  Copyright © 2020 Distillery. All rights reserved.
//

import SwiftUI

public enum CarouselLayoutOrientation {
    case horizontal, vertical
}

public protocol CarouselLayout {
    // Configuration
    var itemSize: CGSize { get set }
    var orientation: CarouselLayoutOrientation { get }
    var infiniteScroll: Bool { get set }

    // Layout methods
    func visibleIndices(selectedIndex: Int, parentFrame: CGRect) -> ClosedRange<Int>
    func calculateGeometryAttributes(atIndex: Int, selectedIndex: Int, dragOffset: CGPoint, parentFrame: CGRect) -> GeometryAttributes
}
