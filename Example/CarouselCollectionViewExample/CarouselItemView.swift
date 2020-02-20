//
//  CarouselItemView.swift
//  CarouselCollectionViewExample
//
//  Created by Denis Shalagin on 19.02.2020.
//  Copyright © 2020 Distillery. All rights reserved.
//

import SwiftUI

public struct CarouselItemView : View {
    var title: String
    var color: UIColor
    
    public var body: some View {
        GeometryReader { geometry in
            Text(self.title)
                .font(Font.system(.largeTitle))
                .frame(width: geometry.size.width, height: geometry.size.height)
                .background(Color.init(self.color))
        }
    }
}
