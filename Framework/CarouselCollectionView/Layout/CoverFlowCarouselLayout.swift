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
    }
    
    //MARK: Override
    
    override func calculateFrame(forItemAtIndex index: Int, selectedIndex: Int, dragOffset: CGFloat, parentFrame: CGRect) -> CGRect {
        // Calculate position
        let position = self.calculatePosition(forItemAtIndex: index, selectedIndex: selectedIndex, dragOffset: dragOffset, parentFrame: parentFrame)
        
        let frame = CGRect(x: position.x - itemSize.width / 2,
                           y: position.y - itemSize.height / 2,
                           width: itemSize.width,
                           height: itemSize.height)
        
        return frame
    }
    
    override func rotation3DEffect(forItemAtIndex index: Int, selectedIndex: Int, position: CGPoint, inFrame frame: CGRect, dragOffset: CGFloat) -> (angle: Angle, axis: (x: CGFloat, y: CGFloat, z: CGFloat)) {
        
        let itemOffset = index - selectedIndex
        
        var offset = dragOffset
        if abs(offset) > itemSize.width {
            if offset < 0 {
                offset = offset + itemSize.width
            } else {
                offset = offset - itemSize.width
            }
        }
                    
        var angle: Double = 0.0
        let offsetAngle = Double((Double(offset) * Constants.rotationAngle) / Double(itemSize.width))
                
        if itemOffset < -1 || position.x <= (frame.width / 2 - itemSize.width) {
            angle = Constants.rotationAngle
        } else if itemOffset > 1 || position.x >= (frame.width / 2 + itemSize.width) {
            angle = -Constants.rotationAngle
        } else {
            if position.x < frame.width / 2 {
                angle = (offset > 0 ? (Constants.rotationAngle - offsetAngle) : -offsetAngle)
                
            } else if position.x > frame.width / 2 {
                angle = (offset > 0 ? -offsetAngle : (-Constants.rotationAngle - offsetAngle))
            }
        }
                        
        return (angle: .degrees(angle), axis: (x: 0, y: 1, z: 0))
    }
    
    override func zIndex(forItemAtIndex index: Int, selectedIndex: Int) -> Double {
        let itemOffset = Double(index - selectedIndex)
        
        return -itemOffset
    }
    
    
    //MARK: Private helpers
    
    func calculatePosition(forItemAtIndex index: Int, selectedIndex: Int, dragOffset: CGFloat, parentFrame: CGRect) -> CGPoint {
        // Calculate item offset to selected index
        let itemOffset = CGFloat(index - selectedIndex)
        
        // Calculate horizontal offset from current index to selected index
        let scrollOffset = (parentFrame.width / 2) + (itemOffset * itemSize.width) + dragOffset
        
        return CGPoint(x: scrollOffset, y: parentFrame.height / 2)
    }
}
