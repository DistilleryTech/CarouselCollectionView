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
    func calculateFrame(forItemAtIndex: Int, selectedIndex: Int, dragOffset: CGFloat, parentFrame: CGRect) -> CGRect
    func rotation3DEffect(forItemAtIndex: Int, selectedIndex: Int, position: CGPoint, inFrame: CGRect, dragOffset: CGFloat) -> (angle: Angle, axis: (x: CGFloat, y: CGFloat, z: CGFloat))
    func zIndex(forItemAtIndex: Int, selectedIndex: Int) -> Double
}
