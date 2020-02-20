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
        static let minimumScaleFactor: CGFloat = 0.75
    }
    
    //MARK: Override
    
    override func calculatePosition(forItemAtIndex index: Int, selectedIndex: Int, dragOffset: CGFloat, parentFrame: CGRect) -> CGPoint {
        // Calculate item offset to selected index
        let itemOffset = CGFloat(index - selectedIndex)
        
        // Calculate horizontal offset from current index to selected index
        let scrollOffset = (parentFrame.width / 2) + (itemOffset * itemSize.width) + dragOffset
        
        return CGPoint(x: scrollOffset, y: parentFrame.height / 2)
    }
    
    override func calculateSize(atPosition position: CGPoint, inFrame frame: CGRect) -> CGSize {
        let scaleFactor = 1.0 - abs(frame.midX - position.x) * (1 - Constants.minimumScaleFactor) / frame.midX
                
        return CGSize(width: itemSize.width * scaleFactor, height: itemSize.height * scaleFactor)
    }
}
