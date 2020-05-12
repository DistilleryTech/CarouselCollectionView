//
//  ContentView.swift
//  CarouselCollectionViewExample
//
//  Created by Denis Shalagin on 07.02.2020.
//  Copyright © 2020 Distillery. All rights reserved.
//

import SwiftUI
import CarouselCollectionView

struct ContentView: View {
    
    //MARK: Constants
    
    private enum Constants {
        static let itemsCount = 100000
        static let flowPickerItems = [CarouselFlowPickerItem(title: "Cover Flow", value: .coverFlow),
                                      CarouselFlowPickerItem(title: "Linear", value: .linear)]
    }
    
    //MARK: Properties
    
    var itemSize: CGSize {
        return .init(width: UIScreen.main.bounds.size.width / 1.5, height: UIScreen.main.bounds.size.width / 1.5)
    }
    
    var layout: CarouselLayout {
        var layout = CarouselLayoutBuilder.build(flow: self.selectedCarouselFlow.value)
        layout.itemSize = itemSize
        
        return layout
    }
    
    
    //MARK: State
    
    @State var selectedIndex = 0
    @State var selectedCarouselFlow: CarouselFlowPickerItem = Constants.flowPickerItems[0]
    
    
    //MARK: View
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 50) {
                Spacer()
                CarouselCollectionView(layout: self.layout, dataSource: self, selectedIndex: self.$selectedIndex).frame(width: geometry.frame(in: .global).width, height: self.itemSize.height)
                Spacer()
                Picker("Select carousel flow style", selection: self.$selectedCarouselFlow) {
                    ForEach(Constants.flowPickerItems, id: \.self) { item in
                        Text(item.title)
                    }
                }
                .labelsHidden()
            }
        }.edgesIgnoringSafeArea(.all)
    }
}

extension ContentView: CarouselCollectionViewDataSource {
    typealias ItemView = CarouselItemView
    
    func numberOfItems() -> Int {
        return Constants.itemsCount
    }
    
    func viewForItem(atIndex index: Int) -> CarouselItemView {
        return CarouselItemView(index: index)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
