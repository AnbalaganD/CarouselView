//
//  ViewExtension.swift
//  CarouselView
//
//  Created by Anbalagan on 24/11/24.
//

import SwiftUI

extension View {
    func onHeightChanged(perform action: @escaping (CGFloat) -> Void) -> some View {
        self
        .background(
            GeometryReader { geometry in
                Color.clear
                    .preference(key: HeightPreferenceKey.self, value: geometry.size.height)
            }
        )
        .onPreferenceChange(HeightPreferenceKey.self, perform: action)
    }
}
