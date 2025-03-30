# Ecommerce App

A modern, cross-platform ecommerce application built with Flutter, featuring a clean architecture and state management using BLoC pattern.

## Features

- Cross-platform support (iOS, Android, Web, Windows, macOS, Linux)
- Clean architecture implementation
- State management using BLoC pattern
- Local data persistence with SharedPreferences
- Material Design UI components
- Product catalog management
- Shopping cart functionality
- User authentication and profile management

## Getting Started

### Prerequisites

- Flutter SDK (>=3.0.0)
- Dart SDK (>=3.0.0)
- Android Studio / VS Code with Flutter extensions
- Git

### Installation

1. Clone the repository:
```bash
git clone https://github.com/yourusername/ecommerce-app.git
```

2. Navigate to the project directory:
```bash
cd ecommerce-app
```

3. Install dependencies:
```bash
flutter pub get
```

4. Run the app:
```bash
flutter run
```

## Project Structure

```
ecommerce_app/
├── lib/              # Main source code
├── assets/           # Static assets (images, fonts, etc.)
├── test/             # Test files
├── android/          # Android-specific files
├── ios/              # iOS-specific files
├── web/              # Web-specific files
├── windows/          # Windows-specific files
├── macos/            # macOS-specific files
└── linux/            # Linux-specific files
```

## Dependencies

- `flutter_bloc`: State management
- `shared_preferences`: Local data storage
- `equatable`: Value equality comparison
- `cupertino_icons`: iOS-style icons

## Development

### Running Tests

```bash
flutter test
```

### Code Generation

If you need to generate code (e.g., for mocks), run:

```bash
flutter pub run build_runner build
```