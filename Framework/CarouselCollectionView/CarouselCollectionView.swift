//
//  CarouselCollectionView.swift
//  CarouselCollectionView
//
//  Created by Denis Shalagin on 07.02.2020.
//  Copyright © 2020 Distillery. All rights reserved.
//

import SwiftUI

public struct CarouselCollectionView<ItemView: View>: View {
    // Data
    let items: [ItemView]
    let layout: CarouselLayout
    
    // State
    @State private var dragOffset: CGFloat = 0
    @State private var selectedIndex: Int = 0
    
    //MARK: Initialization
    
    public init(layout: CarouselLayout, items:[ItemView]) {
        self.items = items
        self.layout = layout
    }
    
    //MARK: View
    
    public var body: some View {
        GeometryReader { geometry in
            ForEach(0..<self.items.count) { index in
                self.configureItemView(atIndex: index, withFrame: geometry.frame(in: .global))
            }.animation(.easeInOut(duration: 0.5))
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            // Update drag offset
                            self.dragOffset = value.translation.width
                    }
                    .onEnded { value in
                        // Calculate selected index
                        var nextIndex = self.selectedIndex - Int(value.predictedEndTranslation.width / self.layout.itemSize.width)
                                                
                        // Check and fix if it is out of bounds
                        nextIndex = max(nextIndex, 0)
                        nextIndex = min(nextIndex, self.items.count - 1)
                        
                        // Update selected index
                        self.selectedIndex = nextIndex
                        
                        // Reset current drag amount
                        self.dragOffset = 0
                    }
            )
        }
    }
    
    
    //MARK: Private helpers
    
    func configureItemView(atIndex index:Int, withFrame frame:CGRect) -> some View {
        let frame = layout.calculateFrame(forItemAtIndex: index, selectedIndex: selectedIndex, dragOffset: dragOffset, parentFrame: frame)
        
        return self.items[index]
            .padding(self.layout.padding)
            .offset(x: frame.minX, y: frame.minY)
            .frame(width: frame.size.width, height: frame.size.height)
            .onTapGesture {
                self.selectedIndex = index
        }
    }
}
