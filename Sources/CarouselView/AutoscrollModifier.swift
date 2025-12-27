//
//  AutoscrollModifier.swift
//  CarouselView
//
//  Created by Anbalagan on 24/11/24.
//

import SwiftUI

struct AutoscrollModifier: ViewModifier {
    let interval: TimeInterval
    @Binding var isEnabled: Bool
    @Binding var selectedIndex: Int
    let itemCount: Int
    
    @State private var timer: Timer?
    @State private var isInteracting: Bool = false
    
    func body(content: Content) -> some View {
        content
            .onCarouselInteraction { interaction in
                isInteracting = interaction
            }
            .onAppear {
                if isEnabled { startTimer() }
            }
            .onDisappear { stopTimer() }
            .onChange(of: isEnabled) { enabled in
                enabled ? startTimer() : stopTimer()
            }
    }
    
    private func startTimer() {
        stopTimer()
        timer = Timer.scheduledTimer(withTimeInterval: interval, repeats: true) { _ in
            // Pause autoscroll when user is actively interacting with the carousel
            if isInteracting { return }
            withAnimation { selectedIndex = (selectedIndex + 1) % itemCount }
        }
    }
    
    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
}

public extension CarouselView {
    /// Configures automatic scrolling for the carousel.
    ///
    /// Autoscroll automatically pauses when the user interacts with the carousel
    /// (during drag gestures) and resumes when interaction ends.
    ///
    /// - Important: Autoscroll is paused if user interaction is active.
    ///
    /// - Parameters:
    ///   - isEnabled: A binding to control whether autoscroll is enabled.
    ///   - interval: Time interval between automatic scrolls in seconds. Defaults to 3.0.
    /// - Returns: A view with autoscroll configured.
    func autoscroll(_ isEnabled: Binding<Bool>, interval: TimeInterval = 3.0) -> some View {
        self.modifier(
            AutoscrollModifier(
                interval: interval,
                isEnabled: isEnabled,
                selectedIndex: $selectedIndex,
                itemCount: items.count
            )
        )
    }
}
