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
        static let itemSize = CGSize(width: 175, height: 200)
    }
    
    //MARK: Properties
    
    let layout: CarouselLayout
    let items: [CarouselItemView]
    
    //MARK: Initialization
    
    init() {
        self.layout = CarouselLayoutBuilder.build(flow: .coverFlow).itemSize(width: Constants.itemSize.width, height: Constants.itemSize.height)
        self.items = [CarouselItemView(title: "1", color: .red),
                      CarouselItemView(title: "2", color: .green),
                      CarouselItemView(title: "3", color: .blue),
                      CarouselItemView(title: "4", color: .gray),
                      CarouselItemView(title: "5", color: .cyan),
                      CarouselItemView(title: "6", color: .yellow),
                      CarouselItemView(title: "7", color: .magenta),
                      CarouselItemView(title: "8", color: .orange),
                      CarouselItemView(title: "9", color: .brown),
                      CarouselItemView(title: "10", color: .purple)]
    }
    
    //MARK: View
    
    var body: some View {
        CarouselCollectionView(layout: layout, items: items)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
