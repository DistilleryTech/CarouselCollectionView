//
//  LinearCarouselLayout.swift
//  CarouselCollectionView
//
//  Created by Denis Shalagin on 13.03.2020.
//  Copyright © 2020 Distillery. All rights reserved.
//

import SwiftUI

struct LinearCarouselLayout: CarouselLayout {
    
    //MARK: Constants
    
    private enum Constants {
        static let minimumScaleFactor: CGFloat = 0.8
        static let minimumOpacity: Double = 0.5
    }
    
    //MARK: Properties
    
    var itemSize: CGSize = .zero
    
    var orientation: CarouselLayoutOrientation {
        return .horizontal
    }
    
    var infiniteScroll: Bool = false
    
    //MARK: Override
    
    func visibleIndices(selectedIndex: Int, parentFrame: CGRect) -> ClosedRange<Int> {
        let itemsPerFrame = Int(ceil(parentFrame.width / itemSize.width))
        let startIndex = max(0, selectedIndex - itemsPerFrame / 2 - 5)
        let endIndex = startIndex + itemsPerFrame + 10
        
        return startIndex...endIndex
    }
    
    func calculateGeometryAttributes(atIndex index: Int, selectedIndex: Int, dragOffset: CGPoint, parentFrame: CGRect) -> GeometryAttributes {
        // calculate frame
        let frame: CGRect = calculateFrame(atIndex: index, selectedIndex: selectedIndex, dragOffset: dragOffset, parentFrame: parentFrame)
                
        // calculate zindex
        let zIndex: Double = 100 - Double(abs(index - selectedIndex))
        
        
        let itemOffset = frame.midX - parentFrame.midX
        
        // calculate opacity
        let opacity: Double = calculateOpacity(withOffset: itemOffset)
        
        // calculate transformation
        let transform = createProjectionTransform(withOffset: itemOffset)
        
        return GeometryAttributes(frame: frame, opacity: opacity, zIndex: zIndex, transform: transform)
    }
    
    
    //MARK: Private
    
    func calculateFrame(atIndex index: Int, selectedIndex: Int, dragOffset: CGPoint, parentFrame: CGRect) -> CGRect {
        // calculate item offset from selected index
        let itemOffset = index - selectedIndex
        
        // calculate horizontal offset from the parent frame center
        let offset = (parentFrame.width / 2) + (CGFloat(itemOffset) * itemSize.width) + dragOffset.x
        
        return CGRect(x: offset - itemSize.width / 2,
                      y: parentFrame.height / 2 - itemSize.height / 2,
                      width: itemSize.width,
                      height: itemSize.height)
    }
    
    func calculateOpacity(withOffset offset: CGFloat) -> Double {
        var opacity = Constants.minimumOpacity
        
        if offset == 0 {
            opacity = 1
        } else if abs(offset) < itemSize.width {
            opacity = 1 - ((1 - Constants.minimumOpacity) / Double(itemSize.width)) * Double(abs(offset))
        }
                
        return opacity
    }
    
    func createProjectionTransform(withOffset offset: CGFloat) -> ProjectionTransform {
        // calculate scale factor
        var scale = Constants.minimumScaleFactor
        
        if offset == 0 {
            scale = 1
        } else if abs(offset) < itemSize.width {
            scale = 1 - (1 - Constants.minimumScaleFactor) / itemSize.width * abs(offset)
        }
        
        // Create scale transformation
        var transform3d = CATransform3DIdentity;
        
        transform3d = CATransform3DTranslate(transform3d, itemSize.width / 2, itemSize.height / 2, 0);
        transform3d = CATransform3DScale(transform3d, scale, scale, 1);
        transform3d = CATransform3DTranslate(transform3d, -itemSize.width / 2, -itemSize.height / 2, 0);
        
        return ProjectionTransform(transform3d)
    }
}
