//
//  CarouselCollectionView.swift
//  CarouselCollectionView
//
//  Created by Denis Shalagin on 07.02.2020.
//  Copyright © 2020 Distillery. All rights reserved.
//

import SwiftUI

public protocol CarouselCollectionViewDataSource {
    associatedtype ItemView: View
    
    func numberOfItems() -> Int
    func viewForItem(atIndex: Int) -> ItemView
}

public struct CarouselCollectionView<T>: View where T: CarouselCollectionViewDataSource {
    
    //MARK: Constants
    
    private enum Constants {
        static var animationDuration: Double {
            return 0.5
        }
    }
    
    //MARK: Properties
    
    // Data
    let layout: CarouselLayout
    let dataSource: T
    
    // Binding
    @Binding var selectedIndex: Int
    
    // State
    @State private var dragOffset: CGPoint = .zero
    
    //MARK: Initialization
    
    public init(layout: CarouselLayout, dataSource: T, selectedIndex: Binding<Int>) {
        self.layout = layout
        self.dataSource = dataSource
        
        self._selectedIndex = selectedIndex
    }
    
    //MARK: View
    
    public var body: some View {
        ZStack{
            GeometryReader { geometry in
                ForEach(self.layout.visibleIndices(inFrame: geometry.frame(in: .global), selectedIndex: self.selectedIndex), id: \.self) { index in
                    self.configureView(atIndex: index, inFrame: geometry.frame(in: .global))
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
                            let itemsCount = self.dataSource.numberOfItems()
                            nextIndex = max(nextIndex, 0)
                            nextIndex = min(nextIndex, itemsCount - 1)
                            
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
        
    func configureView(atIndex index:Int, inFrame frame:CGRect) -> some View {
        let geometry = layout.calculateGeometryAttributes(atIndex: index,
                                                          selectedIndex: selectedIndex,
                                                          dragOffset: dragOffset,
                                                          parentFrame: frame)
        let viewItem = self.dataSource.viewForItem(atIndex: index)
        return viewItem
            .modifier(TransformGeometryEffect(transform: geometry.transform))
            .offset(x: geometry.frame.minX, y: geometry.frame.minY)
            .frame(width: geometry.frame.size.width, height: geometry.frame.size.height)
            .opacity(geometry.opacity)
            .zIndex(geometry.zIndex)
            .onTapGesture {
                self.selectedIndex = index
        }
    }
}
