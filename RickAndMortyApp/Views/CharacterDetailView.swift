//
//  CharacterDetailView.swift
//  RickAndMortyApp
//
//  Created by graffiti75 on 18/12/25.
//

import SwiftUI

struct CharacterDetailView: View {
    let character: Character
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Character Image
                AsyncImage(url: URL(string: character.image)) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                            .frame(width: 300, height: 300)
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 300, height: 300)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                            .shadow(color: Color.black.opacity(0.3), radius: 10, x: 0, y: 5)
                    case .failure:
                        Image(systemName: "photo.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 300, height: 300)
                            .foregroundColor(.gray)
                    @unknown default:
                        EmptyView()
                    }
                }
                .padding(.top, 20)
                
                // Character Name
                Text(character.name)
                    .font(.system(size: 32, weight: .bold))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                
                // Status Badge
                HStack(spacing: 8) {
                    Circle()
                        .fill(statusColor(for: character.status))
                        .frame(width: 12, height: 12)
                    
                    Text(character.status)
                        .font(.headline)
                        .foregroundColor(statusColor(for: character.status))
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(
                    Capsule()
                        .fill(statusColor(for: character.status).opacity(0.2))
                )
                
                // Information Cards
                VStack(spacing: 16) {
                    InfoCard(title: "Species", value: character.species, icon: "pawprint.fill")
                    InfoCard(title: "Gender", value: character.gender, icon: "person.fill")
                    InfoCard(title: "Origin", value: character.origin.name, icon: "globe")
                    InfoCard(title: "Last Known Location", value: character.location.name, icon: "location.fill")
                    
                    if !character.type.isEmpty {
                        InfoCard(title: "Type", value: character.type, icon: "tag.fill")
                    }
                    
                    // Episode Count
                    InfoCard(
                        title: "Episodes",
                        value: "\(character.episode.count) episode\(character.episode.count == 1 ? "" : "s")",
                        icon: "tv.fill"
                    )
                }
                .padding(.horizontal)
                .padding(.bottom, 30)
            }
        }
        .background(Color(.systemGroupedBackground))
        .navigationBarTitleDisplayMode(.inline)
    }
    
    // Helper function to determine status color
    private func statusColor(for status: String) -> Color {
        switch status.lowercased() {
        case "alive":
            return .green
        case "dead":
            return .red
        case "unknown":
            return .gray
        default:
            return .gray
        }
    }
}

// Reusable Info Card Component
struct InfoCard: View {
    let title: String
    let value: String
    let icon: String
    
    var body: some View {
        HStack(spacing: 16) {
            // Icon
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(.blue)
                .frame(width: 40)
            
            // Content
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.caption)
                    .foregroundColor(.secondary)
                
                Text(value)
                    .font(.body)
                    .fontWeight(.medium)
            }
            
            Spacer()
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.15), radius: 5, x: 0, y: 2)
    }
}

#Preview {
    NavigationView {
        CharacterDetailView(
            character: sampleCharacter()
        )
    }
}
