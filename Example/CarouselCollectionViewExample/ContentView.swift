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
    }
    
    //MARK: Properties
    
    var itemSize: CGSize {
        return .init(width: UIScreen.main.bounds.size.width / 1.5, height: UIScreen.main.bounds.size.width / 1.5)
    }
    
    var layout: CarouselLayout {
        return CarouselLayoutBuilder.build(flow: CarouselFlow(rawValue: self.selectedStyle)!).itemSize(width: itemSize.width, height: itemSize.height)
    }
    
    @State var selectedIndex = 0
    @State var selectedStyle = 0
    
    //MARK: View
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 50) {
                Spacer()
                CarouselCollectionView(dataSource: self, layout: self.layout, selectedIndex: self.$selectedIndex).frame(width: geometry.frame(in: .global).width, height: self.itemSize.height)
                Spacer()
                Picker("Select carousel style", selection: self.$selectedStyle) {
                    ForEach(0 ..< CarouselFlow.titles.count) {
                        Text(CarouselFlow.titles[$0])
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
