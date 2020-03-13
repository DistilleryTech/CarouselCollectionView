//
//  CoverFlowCarouselLayout.swift
//  CoverFlowCarouselLayout
//
//  Created by Denis Shalagin on 20.02.2020.
//  Copyright © 2020 Distillery. All rights reserved.
//

import SwiftUI

class CoverFlowCarouselLayout: BaseCarouselLayout {
    //MARK: Constants
    
    private enum Constants {
        static let minimumScaleFactor: CGFloat = 0.8
        static let rotationAngle: Double = 30
        static let translatePerspective: CGFloat = -1.0 / 500.0
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
        var angle: Double = 0
        if offset >= itemSize.width {
            angle = -Constants.rotationAngle
        } else if offset <= -itemSize.width {
            angle = Constants.rotationAngle
        } else {
            angle = Double(-(offset * CGFloat(Constants.rotationAngle)) / itemSize.width)
        }
                        
        var transform3d = CATransform3DIdentity;
        transform3d.m34 = -1/max(itemSize.width, itemSize.height)
        
        transform3d = CATransform3DRotate(transform3d, CGFloat(Angle(degrees: angle).radians), 0, 1, 0)
        transform3d = CATransform3DTranslate(transform3d, -itemSize.width / 2.0, -itemSize.height / 2.0, 0)
        
        let affineTransform = ProjectionTransform(CGAffineTransform(translationX: itemSize.width / 2.0, y: itemSize.height / 2.0))
        
        return ProjectionTransform(transform3d).concatenating(affineTransform)
    }
}
