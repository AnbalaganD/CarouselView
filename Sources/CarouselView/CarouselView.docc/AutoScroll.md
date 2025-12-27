# Auto-scroll

Enable automatic scrolling with customizable intervals.

## Overview

The autoscroll modifier enables automatic progression through carousel items at a specified interval.

> Important: Auto-scroll automatically pauses when the user interacts with the carousel and resumes when interaction ends.

## Example

```swift
import CarouselView

struct ContentView: View {
    private let items: [String] = ["One", "Two", "Three", "Four", "Five"]
    @State private var selectedIndex: Int = 0
    @State private var autoScrollEnabled: Bool = true
    
    var body: some View {
        CarouselView(
            items,
            spacing: 10.0,
            selectedIndex: $selectedIndex
        ) { item in
            Text(item)
                .frame(maxWidth: .infinity)
                .frame(height: 200)
                .background(Color.blue)
                .clipShape(RoundedRectangle(cornerSize: .init(width: 5, height: 5)))
        }
        .autoscroll($autoScrollEnabled, interval: 3.0)
    }
}
```
