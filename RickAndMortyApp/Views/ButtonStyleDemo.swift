//
//  ButtonStyleDemo.swift
//  RickAndMortyApp
//
//  Created by graffiti75 on 18/12/25.
//

import SwiftUI

struct ButtonStyleDemo: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                Group {
                    Text("PlainButtonStyle")
                        .font(.headline)
                    Button("Tap Me") {
                        print("Tapped")
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                
                Divider()
                
                Group {
                    Text("DefaultButtonStyle")
                        .font(.headline)
                    Button("Tap Me") {
                        print("Tapped")
                    }
                    .buttonStyle(DefaultButtonStyle())
                }
                
                Divider()
                
                Group {
                    Text("BorderedButtonStyle")
                        .font(.headline)
                    Button("Tap Me") {
                        print("Tapped")
                    }
                    .buttonStyle(BorderedButtonStyle())
                }
                
                Divider()
                
                Group {
                    Text("BorderedProminentButtonStyle")
                        .font(.headline)
                    Button("Tap Me") {
                        print("Tapped")
                    }
                    .buttonStyle(BorderedProminentButtonStyle())
                }
                
                Divider()
                
                Group {
                    Text("BorderlessButtonStyle")
                        .font(.headline)
                    Button("Tap Me") {
                        print("Tapped")
                    }
                    .buttonStyle(BorderlessButtonStyle())
                }
            }
            .padding()
        }
    }
}

#Preview {
    ButtonStyleDemo()
}
