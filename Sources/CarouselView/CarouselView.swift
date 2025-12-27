//
//  CarouselView.swift
//  CarouselView
//
//  Created by Anbalagan on 24/11/24.
//

import SwiftUI

/// A SwiftUI view that displays items in an infinite scrolling carousel.
///
/// `CarouselView` provides a horizontal scrolling interface with infinite loop support,
/// allowing users to swipe through items seamlessly. The view automatically handles
/// wrapping at boundaries to create a continuous scrolling experience.
///
/// The carousel tracks user interaction state internally and exposes it through the
/// `.onCarouselInteraction()` modifier, enabling features like auto-pause during manual scrolling.
///
/// Example usage:
/// ```swift
/// CarouselView(
///     items,
///     spacing: 10.0,
///     selectedIndex: $selectedIndex
/// ) { item in
///     Text(item)
///         .frame(maxWidth: .infinity)
///         .frame(height: 200)
/// }
/// .autoscroll($isEnabled, interval: 3.0)
/// .onCarouselInteraction { isInteracting in
///     print("User is interacting: \(isInteracting)")
/// }
/// ```
public struct CarouselView<T, Content: View>: View {
    let items: [T]
    let spacing: CGFloat
    @Binding var selected: T?
    @Binding var selectedIndex: Int
    @ViewBuilder let content: (T) -> Content
    
    @State private var height: CGFloat = 0.0
    @State private var dragOffsetX: CGFloat = 0.0
    @State private var previousOffsetX: CGFloat = 0.0
    @State private var tabItem: [T] = []
    @State private var lastSelectedIndex: Int = 0
    @State private var viewWidth: CGFloat = 0
    @GestureState private var isInteracting: Bool = false
    
    /// Creates a carousel view with item-based selection tracking.
    /// 
    /// - Parameters:
    ///   - items: The array of items to display in the carousel.
    ///   - spacing: The horizontal spacing between items. Defaults to 0.0.
    ///   - selected: A binding to the currently selected item.
    ///   - content: A view builder that creates the view for each item.
    public init(
        _ items: [T],
        spacing: CGFloat = 0.0,
        selected: Binding<T?>,
        @ViewBuilder content: @escaping (T) -> Content
    ) {
        self.items = items
        self.spacing = spacing
        self._selectedIndex = .constant(0)
        self._selected = selected
        self.content = content
    }
    
    /// Creates a carousel view with index-based selection tracking.
    /// 
    /// - Parameters:
    ///   - items: The array of items to display in the carousel.
    ///   - spacing: The horizontal spacing between items. Defaults to 0.0.
    ///   - selectedIndex: A binding to the index of the currently selected item.
    ///   - content: A view builder that creates the view for each item.
    public init(
        _ items: [T],
        spacing: CGFloat = 0.0,
        selectedIndex: Binding<Int>,
        @ViewBuilder content: @escaping (T) -> Content
    ) {
        self.items = items
        self.spacing = spacing
        self._selectedIndex = selectedIndex
        self._selected = .constant(nil)
        self.content = content
    }
    
    public var body: some View {
        GeometryReader { geometry in
            if !tabItem.isEmpty {
                HStack(spacing: spacing) {
                    content(tabItem[0])
                        .frame(width: geometry.size.width)
                        .onHeightChanged { self.height = max(self.height, $0) }
                    content(tabItem[1])
                        .frame(width: geometry.size.width)
                        .onHeightChanged { self.height = max(self.height, $0) }
                    content(tabItem[2])
                        .frame(width: geometry.size.width)
                        .onHeightChanged { self.height = max(self.height, $0) }
                }
                .offset(x: dragOffsetX)
                .task(id: geometry.size.width) {
                    viewWidth = geometry.size.width
                    if dragOffsetX == 0 {
                        dragOffsetX = -(geometry.size.width + spacing)
                    }
                }
                .contentShape(.interaction, Rectangle())
                .gesture(
                    DragGesture(minimumDistance: 0)
                        .updating($isInteracting) { _, state, _ in
                            state = true
                        }
                        .onChanged { value in
                            dragOffsetX = dragOffsetX + (value.translation.width - previousOffsetX)
                            previousOffsetX = value.translation.width
                        }.onEnded { value in
                            defer { previousOffsetX = 0 }
                            
                            let isReachedThreshold = abs(value.translation.width) > geometry.size.width / 3
                            
                            if !isReachedThreshold {
                                withAnimation { dragOffsetX = -(geometry.size.width + spacing) }
                                return
                            }
                            
                            let isForward: Bool
                            if value.startLocation.x > value.location.x {
                                selectedIndex = nextIndex()
                                isForward = true
                            } else {
                                selectedIndex = previousIndex()
                                isForward = false
                            }
                            selected = items[selectedIndex]
                            
                            withAnimation { dragOffsetX = isForward ? -geometry.size.width * 2 : 0 }
                            
                            dragOffsetX = -(geometry.size.width + spacing)
                            constructTabItem()
                        }
                )
            }
        }
        .frame(height: height)
        .clipped()
        .preference(key: CarouselInteractionKey.self, value: isInteracting)
        .onAppear {
            lastSelectedIndex = selectedIndex
            constructTabItem() 
        }
        .onChange(of: selectedIndex) { newIndex in
            animateToIndex(newIndex)
        }
    }
    
    private func constructTabItem() {
        if items.isEmpty {
            tabItem = []
            return
        }
        
        selectedIndex = max(0, min(selectedIndex, items.count - 1))
        tabItem = [
            items[previousIndex()],
            items[selectedIndex],
            items[nextIndex()]
        ]
    }
    
    private func previousIndex() -> Int {
        (selectedIndex - 1) < 0 ? items.count - 1 : selectedIndex - 1
    }

    private func nextIndex() -> Int {
        (selectedIndex + 1) % items.count
    }
    
    private func animateToIndex(_ newIndex: Int) {
        let index = max(0, min(newIndex, items.count - 1))
        guard index != lastSelectedIndex, viewWidth > 0 else { return }
        
        let isForward = (index > lastSelectedIndex) || (lastSelectedIndex == items.count - 1 && index == 0)
        lastSelectedIndex = index
        
        withAnimation { dragOffsetX = isForward ? -(viewWidth + spacing) * 2 : 0 }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            dragOffsetX = -(viewWidth + spacing)
            constructTabItem()
        }
    }
}
