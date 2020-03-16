//
//  LinearCarouselLayout.swift
//  CarouselCollectionView
//
//  Created by Denis Shalagin on 13.03.2020.
//  Copyright © 2020 Distillery. All rights reserved.
//

import UIKit

import SwiftUI

class LinearCarouselLayout: BaseCarouselLayout {
    //MARK: Constants
    
    private enum Constants {
        static let minimumScaleFactor: CGFloat = 0.8
    }
    
    //MARK: Override
    
    override func calculateGeometryAttributes(atIndex index: Int, selectedIndex: Int, dragOffset: CGPoint, parentFrame: CGRect) -> GeometryAttributes {
        // calculate frame
        let frame: CGRect = calculateFrame(atIndex: index, selectedIndex: selectedIndex, dragOffset: dragOffset, parentFrame: parentFrame)
        
        // calculate zindex
        let zIndex: Double = 100 - Double(abs(index - selectedIndex))
        
        // calculate transform
        let itemOffset = frame.midX - parentFrame.midX
        let transform = createProjectionTransform(withOffset: itemOffset)
        
        return GeometryAttributes(frame: frame, zIndex: zIndex, transform: transform)
    }
    
    
    //MARK: Private
    
    func calculateFrame(atIndex index: Int, selectedIndex: Int, dragOffset: CGPoint, parentFrame: CGRect) -> CGRect {
        let itemOffset = index - selectedIndex
        
        let scrollOffset = (parentFrame.width / 2) + (CGFloat(itemOffset) * itemSize.width) + dragOffset.x
        
        return CGRect(x: scrollOffset - itemSize.width / 2,
                      y: parentFrame.height / 2 - itemSize.height / 2,
                      width: itemSize.width,
                      height: itemSize.height)
    }
    
    func createProjectionTransform(withOffset offset: CGFloat) -> ProjectionTransform {
        var scale = Constants.minimumScaleFactor
        
        if offset == 0 {
            scale = 1
        } else if abs(offset) < itemSize.width {
            scale = 1 - (1 - Constants.minimumScaleFactor) / itemSize.width * abs(offset)
        }
        
        var transform3d = CATransform3DIdentity;
        
        transform3d = CATransform3DTranslate(transform3d, itemSize.width / 2, itemSize.height / 2, 0);
        transform3d = CATransform3DScale(transform3d, scale, scale, 1);
        transform3d = CATransform3DTranslate(transform3d, -itemSize.width / 2, -itemSize.height / 2, 0);
        
        return ProjectionTransform(transform3d)
    }
}
