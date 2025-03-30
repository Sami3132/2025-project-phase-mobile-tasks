# Shoe Store App

A Flutter application for managing a shoe store inventory. The app allows users to view, add, update, and delete shoe products with features like search and filtering.

## Features

- View list of available shoes
- Add new shoes to inventory
- Update existing shoe details
- Delete shoes from inventory
- Search functionality
- Price range filtering
- Size selection
- Image upload support

## Project Structure

```
lib/
  ├── models/         # Data models
  ├── screens/        # UI screens
  ├── widgets/        # Reusable widgets
  ├── utils/          # Utility functions and constants
  └── main.dart       # Entry point
```

## Getting Started

1. Clone the repository
2. Install dependencies:
   ```bash
   flutter pub get
   ```
3. Run the app:
   ```bash
   flutter run
   ```

## Dependencies

- Flutter SDK
- image_picker: For image upload functionality
- cached_network_image: For better image loading
- intl: For date formatting

## Testing

Run the tests using:
```bash
flutter test
```
