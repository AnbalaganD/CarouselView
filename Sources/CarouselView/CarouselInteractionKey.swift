//
//  CarouselInteractionKey.swift
//  CarouselView
//
//  Created by Anbalagan on 27/12/25.
//

import SwiftUI

/// A preference key for communicating carousel interaction state from child to parent views.
///
/// This key is used internally by `CarouselView` to propagate user interaction state
/// up the view hierarchy, enabling features like auto-pause during manual scrolling.
struct CarouselInteractionKey: PreferenceKey {
    static var defaultValue: Bool = false
    
    static func reduce(value: inout Bool, nextValue: () -> Bool) {
        value = nextValue()
    }
}

public extension View {
    /// Observes carousel interaction state changes.
    ///
    /// Use this modifier to respond to user interaction with a `CarouselView`.
    /// The action closure is called whenever the interaction state changes.
    ///
    /// - Parameter action: A closure that receives the interaction state.
    ///   `true` when the user is actively dragging the carousel, `false` otherwise.
    /// - Returns: A view that responds to carousel interaction changes.
    func onCarouselInteraction(_ action: @escaping (Bool) -> Void) -> some View {
        self.onPreferenceChange(CarouselInteractionKey.self, perform: action)
    }
}
