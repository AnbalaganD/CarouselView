# ``CarouselView``

A SwiftUI library for creating infinite scrolling carousels with auto-scroll support.

## Overview

CarouselView simplifies the implementation of carousel-style interfaces in SwiftUI applications while maintaining smooth, infinite scrolling functionality.

## Features

- ♾️ Infinite scrolling support
- 🎯 Selected item tracking
- 📏 Configurable item spacing
- 📍 Current index monitoring
- 🔄 Auto-scroll with customizable interval
- ⏸️ Auto-pause on user interaction
- ⚡️ Native SwiftUI implementation

## Topics

### Creating a Carousel

- ``CarouselView/init(_:spacing:selected:content:)``
- ``CarouselView/init(_:spacing:selectedIndex:content:)``

### Modifiers

- ``CarouselView/autoscroll(_:interval:)``
- ``SwiftUI/View/onCarouselInteraction(_:)``

### Articles

- <doc:BasicUsage>
- <doc:AutoScroll>
- <doc:ObservingUserInteraction>
