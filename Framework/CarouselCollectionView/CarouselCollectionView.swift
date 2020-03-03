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
    
    // Binding
    @Binding var selectedIndex: Int
    
    // State
    @State private var dragOffset: CGFloat = 0
    
    //MARK: Initialization
    
    public init(layout: CarouselLayout, items:[ItemView], selectedIndex: Binding<Int>) {
        self.items = items
        self.layout = layout
        
        self._selectedIndex = selectedIndex
    }
    
    //MARK: View
    
    public var body: some View {
        ZStack{
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
    }
    
    
    //MARK: Private helpers
    
    func configureItemView(atIndex index:Int, withFrame frame:CGRect) -> some View {
        let itemFrame = layout.calculateFrame(forItemAtIndex: index, selectedIndex: selectedIndex, dragOffset: dragOffset, parentFrame: frame)
        let (rotationAngle, rotationAxis) = layout.rotation3DEffect(forItemAtIndex: index, selectedIndex: selectedIndex, position: CGPoint(x: itemFrame.midX, y: itemFrame.midY), inFrame: frame, dragOffset: dragOffset)
        let zIndex = layout.zIndex(forItemAtIndex: index, selectedIndex: selectedIndex)
        
        return self.items[index]
            .rotation3DEffect(rotationAngle, axis: rotationAxis)
            .offset(x: itemFrame.minX, y: itemFrame.minY)
            .frame(width: itemFrame.size.width, height: itemFrame.size.height)
            .zIndex(zIndex)
            .onTapGesture {
                self.selectedIndex = index
        }
    }
}
