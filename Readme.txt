Readme 

# Australia Cities SwiftUI App

This is a SwiftUI app that displays a list of cities in Australia grouped by state. It fetches data from a backend service and allows users to refresh the data from the backend. In case of a failure to fetch data from the backend, it falls back to using sample data stored locally.

## Features

- Displays cities in Australia grouped by state
- Supports collapsible sections by state
- Dark theme support
- Ability to refresh data from the backend
- Caches data locally until a refresh is required
- Accessibility feature implemented

## Requirements

- Xcode 12 or later
- iOS 14.0 or later

## Dependencies

- None

## Project Structure

- `ContentView.swift`: Main SwiftUI view displaying the list of cities.
- `CityListViewModel.swift`: View model responsible for fetching and managing city data.
- `WelcomeElement.swift`: Model representing a city.
- `BackendService.swift`: Service for fetching city data from the backend.
- `au_cities.json`: Sample data file containing a list of cities in Australia.