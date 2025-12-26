This library simplifies the implementation of carousel-style interfaces in SwiftUI applications while maintaining smooth, infinite scrolling functionality.

![CarouselView](Screenshot/CarouselView.gif)

## Features
♾️ Infinite scrolling support

🎯 Selected item tracking

📏 Configurable item spacing

📍 Current index monitoring

🔄 Auto-scroll with customizable interval

⏸️ Auto-pause on user interaction

⚡️ Native SwiftUI implementation

## Swift Package manager (SPM)
CarouselView is available through [SPM](https://github.com/AnbalaganD/CarouselView). Use below URL to add as a dependency

```swift
dependencies: [
    .package(url: "https://github.com/AnbalaganD/CarouselView", .upToNextMajor(from: "1.1.0"))
]
```

## Usage

### Basic Usage
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

### Auto-scroll
```swift
struct ContentView: View {
    private let items: [String] = ["One", "Two", "Three", "Four", "Five"]
    @State private var selectedIndex: Int = 0
    @State private var isAutoScrollEnabled: Bool = true
    
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
        .autoscroll($isAutoScrollEnabled, interval: 3.0)
    }
}
```

Auto-scroll automatically pauses when the user interacts with the carousel and resumes when interaction ends.

## Author

[Anbalagan D](mailto:anbu94p@gmail.com)

## License

CarouselView is available under the MIT license. See the [LICENSE](LICENSE) file for more info.
