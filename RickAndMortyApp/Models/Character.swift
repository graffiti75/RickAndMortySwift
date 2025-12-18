//
//  Character.swift
//  RickAndMortyApp
//
//  Created by graffiti75 on 17/12/25.
//

import Foundation

// MARK: - API Response Model
struct CharacterResponse: Codable {
    let info: Info
    let results: [Character]
}

struct Info: Codable {
    let count: Int
    let pages: Int
    let next: String?
    let prev: String?
}

// MARK: - Character Model
struct Character: Codable, Identifiable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let type: String
    let gender: String
    let origin: Location
    let location: Location
    let image: String
    let episode: [String]
    let url: String
    let created: String
}

struct Location: Codable {
    let name: String
    let url: String
}

func sampleCharacter() -> Character {
    return Character(
        id: 1,
        name: "Rick Sanchez",
        status: "Alive",
        species: "Human",
        type: "Genetic experiment",
        gender: "Male",
        origin: Location(name: "Earth (C-137)", url: ""),
        location: Location(name: "Citadel of Ricks", url: ""),
        image: "https://rickandmortyapi.com/api/character/avatar/1.jpeg",
        episode: Array(repeating: "", count: 51),
        url: "",
        created: ""
    )
}
