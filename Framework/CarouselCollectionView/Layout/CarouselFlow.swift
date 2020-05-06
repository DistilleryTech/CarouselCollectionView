//
//  CarouselFlow.swift
//  CarouselCollectionView
//
//  Created by Denis Shalagin on 20.02.2020.
//  Copyright © 2020 Distillery. All rights reserved.
//

public enum CarouselFlow: Int {
    case coverFlow
    case linear
    
    public static var titles: [String] {
        get {
            return ["Cover Flow", "Linear"]
        }
    }
}
