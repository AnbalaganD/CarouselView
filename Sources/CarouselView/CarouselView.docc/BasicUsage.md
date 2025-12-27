# Basic Usage

Create a simple carousel with item selection tracking.

## Overview

The most basic implementation of CarouselView requires an array of items, spacing, and a selected index binding.

## Example

```swift
import CarouselView

struct ContentView: View {
    private let items: [String] = ["One", "Two", "Three", "Four", "Five"]
    @State private var selectedIndex: Int = 2
    
    var body: some View {
        CarouselView(
            items,
            spacing: 10.0,
            selectedIndex: $selectedIndex
        ) { item in
            Text(item)
                .frame(maxWidth: .infinity)
                .frame(height: 200)
                .background(Color.gray)
                .clipShape(RoundedRectangle(cornerSize: .init(width: 5, height: 5)))
        }
    }
}
```
