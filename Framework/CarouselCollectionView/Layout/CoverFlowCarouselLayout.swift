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
        static let rotationAngle: Double = 30
    }
    
    //MARK: Override
    
    override func calculateGeometryAttributes(atIndex index: Int, selectedIndex: Int, dragOffset: CGPoint, parentFrame: CGRect) -> GeometryAttributes {
        // calculate frame
        let frame: CGRect = calculateFrame(atIndex: index, selectedIndex: selectedIndex, dragOffset: dragOffset, parentFrame: parentFrame)
        
        // calculate zindex
        let zIndex: Double = 100 - Double(abs(index - selectedIndex))
        
        // calculate transformation
        let itemOffset = frame.midX - parentFrame.midX
        let transform = createProjectionTransform(withOffset: itemOffset)
        
        return GeometryAttributes(frame: frame, zIndex: zIndex, transform: transform)
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
    
    func createProjectionTransform(withOffset offset: CGFloat) -> ProjectionTransform {
        // calculate item angle
        var angle: Double = 0
        if offset >= itemSize.width {
            angle = -Constants.rotationAngle
        } else if offset <= -itemSize.width {
            angle = Constants.rotationAngle
        } else {
            angle = Double(-(offset * CGFloat(Constants.rotationAngle)) / itemSize.width)
        }
                        
        // create transformation
        var transform3d = CATransform3DIdentity;
        transform3d.m34 = -1/max(itemSize.width, itemSize.height)
        
        transform3d = CATransform3DRotate(transform3d, CGFloat(Angle(degrees: angle).radians), 0, 1, 0)
        transform3d = CATransform3DTranslate(transform3d, -itemSize.width / 2.0, -itemSize.height / 2.0, 0)
        
        let affineTransform = ProjectionTransform(CGAffineTransform(translationX: itemSize.width / 2.0, y: itemSize.height / 2.0))
        
        return ProjectionTransform(transform3d).concatenating(affineTransform)
    }
}
