//
//  ContentView.swift
//  CarouselViewSample
//
//  Created by Anbalagan on 23/11/24.
//

import SwiftUI
import CarouselView

struct ContentView: View {
    private let items: [String] = ["One", "Two", "Three", "Four", "Five"]
    @State private var selectedIndex: Int = 2
    @State private var autoScrollEnabled = true
    
    var body: some View {
        VStack(spacing: 10) {
            HStack {
                Button {
                    selectedIndex = Int.random(in: -10...10)
                } label: {
                    Text("Random Index")
                        
                }
                .buttonStyle(.borderedProminent)
                
                Button {
                    autoScrollEnabled = !autoScrollEnabled
                } label: {
                    Text(autoScrollEnabled ? "Disable Auto Scroll" : "Enable Auto Scroll")
                }
                .buttonStyle(.borderedProminent)
            }
            CarouselView(
                items,
                spacing: 10.0,
                selectedIndex: $selectedIndex
            ) { item in
                Text(item)
                    .frame(maxWidth: .infinity)
                    .frame(height: 200)
                    .background(getColor(value: item))
                    .clipShape(RoundedRectangle(cornerSize: .init(width: 5, height: 5)))
            }
            .autoscroll($autoScrollEnabled)
            .onCarouselInteraction { isInteraction in
                print("Interaction: \(isInteraction)")
            }
            .onChange(of: selectedIndex) { newValue in
                print(newValue + 1)
            }
        }
        .padding()
    }
    
    func getColor(value: String) -> Color {
        switch value {
        case "One": return .red
        case "Two": return .blue
        case "Three": return .green
        case "Four": return .yellow
        case "Five": return .orange
        default: return .red
        }
    }
}

#Preview {
    ContentView()
}
