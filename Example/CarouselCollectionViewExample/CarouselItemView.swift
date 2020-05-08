//
//  CarouselItemView.swift
//  CarouselCollectionViewExample
//
//  Created by Denis Shalagin on 19.02.2020.
//  Copyright © 2020 Distillery. All rights reserved.
//

import SwiftUI

public struct CarouselItemView : View {
    var index: Int
    
    public var body: some View {
        GeometryReader { geometry in
            ZStack {
                RadialGradient(gradient: Gradient(colors: [.blue, .black]), center: .center, startRadius: 2, endRadius: geometry.frame(in: .global).width)
                Text("\(self.index)").font(.system(size: 96)).fontWeight(.medium).foregroundColor(.white).opacity(0.25)
            }
        }
    }
}
