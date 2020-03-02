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
    
    func itemSize(width: CGFloat, height: CGFloat) -> CarouselLayout {
        itemSize = CGSize(width: width, height: height)
        
        return self
    }
    
    func calculateFrame(forItemAtIndex index: Int, selectedIndex: Int, dragOffset: CGFloat, parentFrame: CGRect) -> CGRect {
        return .zero
    }
    
    func rotation3DEffect(forItemAtIndex: Int, selectedIndex: Int, position: CGPoint, inFrame: CGRect, dragOffset: CGFloat) -> (angle: Angle, axis: (x: CGFloat, y: CGFloat, z: CGFloat)) {
        return (angle: .degrees(0), axis: (x: 0, y: 0, z: 0))
    }
    
    func zIndex(forItemAtIndex: Int, selectedIndex: Int) -> Double {
        return 0
    }
}
