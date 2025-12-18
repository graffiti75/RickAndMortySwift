# Rick and Morty Character Feed

An iOS app that displays characters from the Rick and Morty API.

## Features

- ✅ Fetches character data from the Rick and Morty API
- ✅ Displays character images and names in a grid layout
- ✅ Async/await for modern concurrency
- ✅ MVVM architecture
- ✅ Error handling with retry functionality
- ✅ Loading states
- ✅ AsyncImage for efficient image loading
- ✅ Responsive grid that adapts to screen size

## Requirements

- iOS 15.0+
- Xcode 14.0+
- Swift 5.5+

## Setup Instructions

1. **Create a new Xcode project:**
   - Open Xcode
   - File → New → Project
   - Select "App" under iOS
   - Product Name: `RickAndMortyApp`
   - Interface: SwiftUI
   - Language: Swift

2. **Add the files to your project:**
   - Create the following folder structure in your project:
     - Models/
     - Services/
     - ViewModels/
     - Views/

3. **Copy the files:**
   - `Character.swift` → Models folder
   - `NetworkService.swift` → Services folder
   - `CharacterViewModel.swift` → ViewModels folder
   - `CharacterCardView.swift` → Views folder
   - `ContentView.swift` → Views folder (replace existing)
   - `RickAndMortyApp.swift` → Root (replace existing)

4. **Run the app:**
   - Select a simulator or device
   - Press Cmd+R or click the Run button

## Architecture

### MVVM Pattern

**Models**
- `Character`: Represents a character from the API
- `CharacterResponse`: Wrapper for the API response

**Services**
- `NetworkService`: Handles all network requests using async/await

**ViewModels**
- `CharacterViewModel`: Manages character data and UI state using `@Published` properties

**Views**
- `ContentView`: Main view with navigation and grid layout
- `CharacterCardView`: Reusable component for displaying individual characters

## API Endpoint

```
https://rickandmortyapi.com/api/character/
```

Returns 20 characters per page by default.

## Key Technologies

- **SwiftUI**: Modern declarative UI framework
- **async/await**: Modern concurrency for network calls
- **@MainActor**: Ensures UI updates happen on the main thread
- **AsyncImage**: Built-in async image loading
- **ObservableObject**: Reactive data binding with ViewModels
- **LazyVGrid**: Efficient grid layout that loads items on demand

## Code Highlights

### Network Call with async/await
```swift
func fetchCharacters(page: Int = 1) async throws -> CharacterResponse {
    let (data, response) = try await URLSession.shared.data(from: url)
    return try JSONDecoder().decode(CharacterResponse.self, from: data)
}
```

### ViewModel with @MainActor
```swift
@MainActor
class CharacterViewModel: ObservableObject {
    @Published var characters: [Character] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
}
```

### Adaptive Grid Layout
```swift
let columns = [GridItem(.adaptive(minimum: 150), spacing: 16)]

LazyVGrid(columns: columns, spacing: 16) {
    ForEach(viewModel.characters) { character in
        CharacterCardView(character: character)
    }
}
```

## Future Enhancements

- Pagination to load more pages
- Pull-to-refresh
- Search functionality
- Character detail view
- Filtering by status/species
- Favorites/bookmarking
- Offline caching

## License

This project uses the public Rick and Morty API: https://rickandmortyapi.com/
