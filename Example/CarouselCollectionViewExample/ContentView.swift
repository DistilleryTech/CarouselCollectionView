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
        static let itemCount = 1000
    }
    
    //MARK: Properties
    
    var itemSize: CGSize {
        return .init(width: UIScreen.main.bounds.size.width / 1.5, height: UIScreen.main.bounds.size.width / 1.5)
    }
    
    var layout: CarouselLayout {
        return CarouselLayoutBuilder.build(flow: CarouselFlow(rawValue: self.selectedStyle)!).itemSize(width: itemSize.width, height: itemSize.height)
    }
    let items: [CarouselItemView]
    
    @State var selectedIndex = 0
    @State var selectedStyle = 0
    
    //MARK: Initialization
    
    init() {
        // Setup items
        var items = [CarouselItemView]()
        (1...Constants.itemCount).forEach { (index) in
            items.append(CarouselItemView(index: index))
        }
        self.items = items
    }
    
    //MARK: View
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 50) {
                Spacer()
                CarouselCollectionView(layout: self.layout, items: self.items, selectedIndex: self.$selectedIndex)
                    .frame(width: geometry.frame(in: .global).width, height: self.itemSize.height)
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
