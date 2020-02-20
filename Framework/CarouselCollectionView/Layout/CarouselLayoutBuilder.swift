//
//  CarouselLayoutBuilder.swift
//  CarouselCollectionView
//
//  Created by Denis Shalagin on 20.02.2020.
//  Copyright © 2020 Distillery. All rights reserved.
//

public struct CarouselLayoutBuilder {
    public static func build(flow: CarouselFlow) -> CarouselLayout {
        var layout: CarouselLayout
        
        switch flow {
        case .coverFlow:
            layout = CoverFlowCarouselLayout()
        }
        
        return layout
    }
}
