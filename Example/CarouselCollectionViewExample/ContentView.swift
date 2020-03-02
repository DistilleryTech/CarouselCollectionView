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
        static let itemSize = CGSize(width: 150, height: 200)
    }
    
    //MARK: Properties
    
    let layout: CarouselLayout
    let items: [CarouselItemView]
    
    // State
    @State var selectedIndex = 0
    
    //MARK: Initialization
    
    init() {
        self.layout = CarouselLayoutBuilder.build(flow: .coverFlow).itemSize(width: Constants.itemSize.width, height: Constants.itemSize.height)
        
        var items = [CarouselItemView]()
        for index in 0..<100 {
            items.append(CarouselItemView(title: "\(index)", color: UIColor.randomColor))
        }
        self.items = items
    }
    
    //MARK: View
    
    var body: some View {
        VStack {
            Text("Selected Item:")
            Text(String(selectedIndex))
                .font(.system(size: 36, weight: .heavy, design: .default))
            CarouselCollectionView(layout: layout, items: items, selectedIndex: $selectedIndex)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
