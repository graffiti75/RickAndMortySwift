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
                    ErrorState(
                        viewModel: viewModel,
                        errorMessage: errorMessage
                    )
                } else {
                    // Success State - Character Grid
                    SuccessState(
                        viewModel: viewModel,
                        columns: columns
                    )
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
            // Set to true to test error case.
            // Change to false to see normal behavior
            viewModel.simulateError = false
            await viewModel.loadCharacters()
        }
    }
}

struct ErrorState: View {
    
    let viewModel: CharacterViewModel
    let errorMessage: String
    
    var body: some View {
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
    }
}

struct SuccessState: View {
    
    let viewModel: CharacterViewModel
    let columns: [GridItem]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(viewModel.characters) { character in
                    NavigationLink(
                        destination: CharacterDetailView(character: character)
                    ) {
                        CharacterCardView(character: character)
                    }
                    .buttonStyle(PlainButtonStyle())
                    .onAppear {
                        // Trigger loading more when approaching the end
                        if viewModel.shouldLoadMore(currentItem: character) {
                            Task {
                                await viewModel.loadMoreCharacters()
                            }
                        }
                    }
                }
                
                // Loading indicator at the bottom
                if viewModel.isLoadingMore {
                    HStack {
                        Spacer()
                        ProgressView()
                            .padding()
                        Spacer()
                    }
                    .gridCellColumns(2)
                }
            }
            .padding()
        }
    }
}

#Preview {
    ContentView()
}
