//
//  TransformGeometryEffect.swift
//  CarouselCollectionView
//
//  Created by Denis Shalagin on 10.03.2020.
//  Copyright © 2020 Distillery. All rights reserved.
//

import SwiftUI

struct TransformGeometryEffect: GeometryEffect {
    var transform: ProjectionTransform

    func effectValue(size: CGSize) -> ProjectionTransform {
        return transform
    }
}
