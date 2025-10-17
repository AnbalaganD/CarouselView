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
    
    func body(content: Content) -> some View {
        content
            .onAppear {
                if isEnabled {
                    startTimer()
                }
            }
            .onDisappear {
                stopTimer()
            }
            .onChange(of: isEnabled) { enabled in
                if enabled {
                    startTimer()
                } else {
                    stopTimer()
                }
            }
    }
    
    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: interval, repeats: true) { _ in
            withAnimation {
                selectedIndex = (selectedIndex + 1) % itemCount
            }
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
    /// - Parameters:
    ///   - isEnabled: Whether autoscroll is enabled. Defaults to true.
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
