//
//  ContentView.swift
//  TypeState-Design-Pattern
//
//  Created by Oleksandr Riabchuk on 10.09.2024.
//

import SwiftUI

/// A SwiftUI View that provides buttons to increase and decrease a counter value.
struct ContentView: View {
    @ObservedObject var counter: CurrentState = .init(state: TurnstileState())

    var body: some View {
        VStack(spacing: 20) {
            Text("Counter Value: \(counter.state.coins())")
                .font(.largeTitle)

            HStack {
                Button(action: {
                    counter.state.insertCoin()
                }) {
                    Text("insertCoin")
                        .padding()
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }

                Button(action: {
                    counter.state.push()
                }) {
                    Text("push")
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
