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
        static let itemSize = CGSize(width: 266, height: 200)
    }
    
    //MARK: Properties
    
    let layout: CarouselLayout
    let items: [CarouselItemView]
    
    @State var selectedIndex = 0
    
    //MARK: Initialization
    
    init() {
        self.layout = CarouselLayoutBuilder.build(flow: .linear).itemSize(width: Constants.itemSize.width, height: Constants.itemSize.height)
        
        var items = [CarouselItemView]()
        for index in 1...10 {
            items.append(CarouselItemView(imageName: "\(index)"))
        }
        self.items = items
    }
    
    //MARK: View
    
    var body: some View {
        VStack {
            CarouselCollectionView(layout: layout, items: items, selectedIndex: $selectedIndex)
            Text("Selected Item:")
            Text(String(selectedIndex))
                .font(.system(size: 36, weight: .heavy, design: .default))
        }
        .background(Color.black)
        .edgesIgnoringSafeArea(.all)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
