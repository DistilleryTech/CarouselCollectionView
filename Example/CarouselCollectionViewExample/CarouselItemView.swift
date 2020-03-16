//
//  CarouselItemView.swift
//  CarouselCollectionViewExample
//
//  Created by Denis Shalagin on 19.02.2020.
//  Copyright © 2020 Distillery. All rights reserved.
//

import SwiftUI

public struct CarouselItemView : View {
    var imageName: String
    
    public var body: some View {
        Image(imageName).resizable()
    }
}
