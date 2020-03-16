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
    
    let images = ["Image_1",
                  "Image_2",
                  "Image_3",
                  "Image_4",
                  "Image_5",
                  "Image_6",
                  "Image_7",
                  "Image_8",
                  "Image_9",
                  "Image_10"
    ]
    
    @State var selectedIndex = 0
    
    //MARK: Initialization
    
    init() {
        self.layout = CarouselLayoutBuilder.build(flow: .coverFlow).itemSize(width: Constants.itemSize.width, height: Constants.itemSize.height)
        
        var items = [CarouselItemView]()
        for image in images {
            items.append(CarouselItemView(imageName: image))
        }
        self.items = items
    }
    
    //MARK: View
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 50) {
                Spacer()
                CarouselCollectionView(layout: self.layout, items: self.items, selectedIndex: self.$selectedIndex)
                    .frame(width: geometry.frame(in: .global).width, height: Constants.itemSize.height)
                Text(self.images[self.selectedIndex])
                    .font(.system(size: 24, weight: .bold, design: .default))
                    .foregroundColor(Color.white)
                Spacer()
            }
            .background(Color.black)
        }.edgesIgnoringSafeArea(.all)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
