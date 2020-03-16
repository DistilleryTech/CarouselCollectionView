# CarouselCollectionView

CarouselCollectionView is a class designed to simplify the implementation of various types of carousel. Powered by SwiftUI and Combine. 

![gif demo](https://github.com/DistilleryTech/CarouselCollectionView/blob/master/demo.gif)


## Usage

```swift
import SwiftUI
import Combine
import CarouselCollectionView

var layout = CarouselLayoutBuilder.build(flow: .coverFlow).itemSize(width: 266, height: 200)

var items = [CarouselItemView]()
let images = ["Image_1", "Image_2", "Image_3", "Image_4", "Image_5"]
for image in images {
	items.append(CarouselItemView(imageName: image))
}
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
```
