//
//  ContentView.swift
//  RickAndMortyApp
//
//  Created by graffiti75 on 17/12/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = CharacterViewModel()
    
    let columns = [
        GridItem(.adaptive(minimum: 150), spacing: 16)
    ]
    
    var body: some View {
        NavigationView {
            ZStack {
                // Background
                Color(.systemGroupedBackground)
                    .ignoresSafeArea()
                
                if viewModel.isLoading {
                    // Loading State
                    ProgressView("Loading Characters...")
                        .scaleEffect(1.2)
                } else if let errorMessage = viewModel.errorMessage {
                    // Error State
                    VStack(spacing: 16) {
                        Image(systemName: "exclamationmark.triangle.fill")
                            .font(.system(size: 50))
                            .foregroundColor(.red)
                        
                        Text("Oops!")
                            .font(.title)
                            .fontWeight(.bold)
                        
                        Text(errorMessage)
                            .font(.body)
                            .multilineTextAlignment(.center)
                            .foregroundColor(.secondary)
                            .padding(.horizontal)
                        
                        Button("Try Again") {
                            Task {
                                await viewModel.loadCharacters()
                            }
                        }
                        .buttonStyle(.borderedProminent)
                    }
                    .padding()
                } else {
                    // Success State - Character Grid
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 16) {
                            ForEach(viewModel.characters) { character in
                                NavigationLink(
                                    destination: CharacterDetailView(
                                        character: character
                                    )
                                ) {
                                    CharacterCardView(character: character)
                                }
                                .buttonStyle(PlainButtonStyle()
                                )
                            }
                        }
                        .padding()
                    }
                }
            }
            .navigationTitle("Rick & Morty")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        Task {
                            await viewModel.loadCharacters()
                        }
                    } label: {
                        Image(systemName: "arrow.clockwise")
                    }
                    .disabled(viewModel.isLoading)
                }
            }
        }
        .task {
            await viewModel.loadCharacters()
        }
    }
}

#Preview {
    ContentView()
}
