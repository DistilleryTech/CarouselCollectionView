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
    
    let layout: CarouselLayout
    let items: [CarouselItemView]
    
    init() {
        self.layout = CarouselLayoutBuilder.build(flow: .coverFlow).set(itemSize: CGSize(width: 125, height: 150)).set(padding: 5)
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
    
    var body: some View {
        CarouselCollectionView(layout: layout, items: items)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
