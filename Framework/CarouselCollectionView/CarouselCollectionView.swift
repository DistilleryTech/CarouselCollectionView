//
//  CarouselCollectionView.swift
//  CarouselCollectionView
//
//  Created by Denis Shalagin on 07.02.2020.
//  Copyright © 2020 Distillery. All rights reserved.
//

import SwiftUI

public struct CarouselCollectionView<ItemView: View>: View {
    
    //MARK: Constants
    
    private enum Constants {
        static var animationDuration: Double {
            return 0.5
        }
    }
    
    //MARK: Properties
    
    // Data
    let items: [ItemView]
    let layout: CarouselLayout
    
    // Binding
    @Binding var selectedIndex: Int
    
    // State
    @State private var dragOffset: CGPoint = .zero
    
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
                ForEach(self.layout.calculateVisibleIndices(inFrame: geometry.frame(in: .global), selectedIndex: self.selectedIndex), id: \.self) { index in
                    self.configureItemView(atIndex: index, withFrame: geometry.frame(in: .global))
                }.animation(.easeInOut(duration: Constants.animationDuration))
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                // Update drag offset
                                self.dragOffset = CGPoint(x: value.translation.width, y: value.translation.height)
                        }
                        .onEnded { value in
                            // Calculate selected index
                            var nextIndex = self.selectedIndex - Int(value.predictedEndTranslation.width / self.layout.itemSize.width * 0.5)
                            
                            // Check and fix if it is out of bounds
                            nextIndex = max(nextIndex, 0)
                            nextIndex = min(nextIndex, self.items.count - 1)
                            
                            // Update selected index
                            self.selectedIndex = nextIndex
                            
                            // Reset current drag offset
                            self.dragOffset = .zero
                        }
                )
            }
        }
    }
    
    
    //MARK: Private helpers
    
    func calculateVisibleItems() -> Range<Int> {
        let visibleOffset = 20
        let startIndex = max(0, self.selectedIndex - visibleOffset / 2)
        let endIndex = startIndex + visibleOffset
        
        return startIndex..<endIndex
    }
    
    func configureItemView(atIndex index:Int, withFrame frame:CGRect) -> some View {        
        let geometry = layout.calculateGeometryAttributes(atIndex: index,
                                                          selectedIndex: selectedIndex,
                                                          dragOffset: dragOffset,
                                                          parentFrame: frame)
        
        return self.items[index]
            .modifier(TransformGeometryEffect(transform: geometry.transform))
            .offset(x: geometry.frame.minX, y: geometry.frame.minY)
            .frame(width: geometry.frame.size.width, height: geometry.frame.size.height)
            .opacity(geometry.opacity)
//            .zIndex(geometry.zIndex) // foreach on gesture doesn't work with this line, needs to be checked with new iOS beta
            .onTapGesture {
                self.selectedIndex = index
        }
    }
}
