//
//  CoverFlowCarouselLayout.swift
//  CoverFlowCarouselLayout
//
//  Created by Denis Shalagin on 20.02.2020.
//  Copyright © 2020 Distillery. All rights reserved.
//

import UIKit

class CoverFlowCarouselLayout: BaseCarouselLayout {
    //MARK: Constants
    
    private enum Constants {
        static let minimumScaleFactor: CGFloat = 0.8
    }
    
    //MARK: Override
    
    override func calculateFrame(forItemAtIndex index: Int, selectedIndex: Int, dragOffset: CGFloat, parentFrame: CGRect) -> CGRect {
        // Calculate position
        let position = self.calculatePosition(forItemAtIndex: index, selectedIndex: selectedIndex, dragOffset: dragOffset, parentFrame: parentFrame)
        
        // Calculate scale
        let scale = self.calculateSize(atPosition: position, inFrame: parentFrame)
        
        // Calculate frame with vertical offset
        let frame = CGRect(x: position.x - scale.width / 2,
                           y: self.calculateVerticalOffset(position: position, scale: scale),
                           width: scale.width,
                           height: scale.height)
        
        return frame
    }
    
    //MARK: Private helpers
    
    func calculatePosition(forItemAtIndex index: Int, selectedIndex: Int, dragOffset: CGFloat, parentFrame: CGRect) -> CGPoint {
        // Calculate item offset to selected index
        let itemOffset = CGFloat(index - selectedIndex)
        
        // Calculate horizontal offset from current index to selected index
        let scrollOffset = (parentFrame.width / 2) + (itemOffset * itemSize.width) + dragOffset
        
        return CGPoint(x: scrollOffset, y: parentFrame.height / 2)
    }
    
    func calculateSize(atPosition position: CGPoint, inFrame frame: CGRect) -> CGSize {
        var scaleFactor: CGFloat
        if frame.contains(position) {
            // Calculate scale factor for visible items
            scaleFactor = 1.0 - abs(frame.midX - position.x) * (1 - Constants.minimumScaleFactor) / frame.midX
        } else {
            // Default scale factor for invisible items
            scaleFactor = Constants.minimumScaleFactor
        }
        
        return CGSize(width: itemSize.width * scaleFactor, height: itemSize.height * scaleFactor)
    }
    
    func calculateVerticalOffset(position:CGPoint, scale: CGSize) -> CGFloat {
        var offset = position.y - scale.height / 2
        
        let diff = itemSize.height - scale.height
        if self.verticalAlignment == .bottom {
            offset += (diff / 2)
        } else if self.verticalAlignment == .top {
            offset -= (diff / 2)
        }
        
        return offset
    }
}
