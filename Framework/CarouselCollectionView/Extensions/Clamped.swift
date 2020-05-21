//
//  Clamped.swift
//  CarouselCollectionView
//
//  Created by Denis Shalagin on 21.05.2020.
//  Copyright © 2020 Distillery. All rights reserved.
//

extension Comparable {
    func clamped(to limits: ClosedRange<Self>) -> Self {
        return min(max(self, limits.lowerBound), limits.upperBound)
    }
}

extension Strideable where Stride: SignedInteger {
    func clamped(to limits: CountableClosedRange<Self>) -> Self {
        return min(max(self, limits.lowerBound), limits.upperBound)
    }
}
