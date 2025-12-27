# Observing User Interaction

Monitor when users interact with the carousel.

## Overview

Use the `onCarouselInteraction` modifier to observe when users are actively dragging the carousel.

## Example

```swift
import CarouselView

struct ContentView: View {
    private let items: [String] = ["One", "Two", "Three", "Four", "Five"]
    @State private var selectedIndex: Int = 0
    
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
        .onCarouselInteraction { isInteracting in
            print("User is interacting: \(isInteracting)")
        }
    }
}
```
