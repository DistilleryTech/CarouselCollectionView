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
                ForEach(self.layout.visibleIndices(selectedIndex: self.selectedIndex, parentFrame: geometry.frame(in: .global)), id: \.self) { index in
                    self.buildView(atIndex: index, inFrame: geometry.frame(in: .global))
                }.animation(.easeInOut)
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                // Update drag offset
                                self.dragOffset = CGPoint(x: value.translation.width, y: value.translation.height)
                        }
                        .onEnded { value in
                            // Calculate next selected index
                            let scrollItemsNumber = Int(ceil(value.predictedEndTranslation.width / (self.layout.itemSize.width * 0.5))).clamped(to: -5...5)

                            let nextIndex = (self.selectedIndex - scrollItemsNumber).clamped(to: 0...self.dataSource.numberOfItems() - 1)
                            
                            if abs(self.selectedIndex - nextIndex) > 1 {
                                self.scroll(toIndex: nextIndex, animated: true)
                            } else {
                                self.selectedIndex = nextIndex
                                self.dragOffset = .zero
                            }
                        }
                )
            }
        }
    }
    
    
    //MARK: Private helpers
    
    private func buildView(atIndex index:Int, inFrame frame:CGRect) -> some View {
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
                self.scroll(toIndex: index, animated: true)
        }
    }
    
    private func scroll(toIndex index:Int, animated: Bool) {
        if index == selectedIndex {
            return
        }
        
        if animated {
            // Animate scrolling by manual drag offset update
            let start: CGFloat = 0
            let end: CGFloat = self.layout.itemSize.width * CGFloat(abs(selectedIndex - index))
            let step: CGFloat = self.layout.itemSize.width / 25
            let scrollBack = index < selectedIndex
            
            var delay: Double = 0
            
            for i in stride(from: start, to: end, by: step) {
                DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                    self.dragOffset = CGPoint(x: scrollBack ? i : -i, y: scrollBack ? i : -i)
                }

                if (end - i) > abs(self.layout.itemSize.width) {
                    delay += 0.0025
                } else {
                    delay += 0.01
                }
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                self.selectedIndex = index
                self.dragOffset = .zero
            }
        } else {
            self.selectedIndex = index
        }
    }
}
