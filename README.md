# RationApp

RationApp is a mobile application designed to help Eritrean dairy farmers calculate optimal feed rations for their livestock. Built with Flutter, the app provides a simple, offline-first interface that enables farmers to make informed feeding decisions based on scientific calculations.

## Purpose

Dairy farming in Eritrea faces challenges with high feed costs and low milk production. RationApp addresses this by:

- Providing a mobile tool for calculating balanced cow feed based on specific animal characteristics
- Working completely offline, essential in areas with limited internet access
- Helping farmers optimize feed costs while maintaining proper nutrition
- Supporting agricultural extension officers during farm visits

## Features

### Cow Characteristics Input
- Input cow details (weight, pregnancy status, milk production, etc.)
- User-friendly dropdown menus and text fields

### Nutritional Requirements Calculator
- Calculates precise nutritional needs based on cow characteristics
- Shows requirements for dry matter, energy, protein, and minerals

### Feed Formula Planner
- Add and edit fodder and concentrate ingredients
- Track nutritional values of feed mixes
- Visual indicators show when nutrient levels meet requirements

### Price Tracking
- Update local feed prices
- Calculate the cost of different feed combinations

### Feed Optimizer
- Suggests the most cost-effective feed mix that meets nutritional requirements

### Multilingual Support
- Available in multiple languages (English, Arabic, Tigrinya)

### Offline Functionality
- All features work without internet connection
- Data is stored locally on the device

## Setup Instructions

### Prerequisites
- Flutter SDK
- Android Studio or VS Code with Flutter extensions
- An Android or iOS device/emulator

### Installation
1. Clone the repository:
   ```
   git clone https://github.com/minerva-university/rationapp.git
   ```

2. Navigate to the project directory:
   ```
   cd rationapp
   ```

3. Get dependencies:
   ```
   flutter clean
   flutter pub get
   ```

4. Run the app:
   ```
   flutter run
   ```

### Building for Distribution
To create an APK file for direct distribution via USB:
```
flutter build apk
```

The APK will be located at `build/app/outputs/flutter-apk/app-release.apk`

## Project Structure

- **constants/** - Static data and configuration
- **data/** - Nutrition tables and local data sources
- **l10n/** - Language localization files
- **models/** - Data structures for core app concepts
- **screens/** - Main UI pages
- **services/** - Business logic and data management
- **utils/** - Calculation utilities including feed optimization
- **widgets/** - Reusable UI components

## Key Components

### Core Calculation Modules
- `cow_requirements_calculator.dart` - Calculates nutritional needs
- `feed_calculator.dart` - Processes feed mixture calculations
- `feed_optimizer.dart` - Implements linear optimization for least-cost feed

### Data Management
- `persistence_manager.dart` - Handles local data storage using SharedPreferences
- `feed_state.dart` - Manages application state for feed ingredients

### User Interface
- `home_screen.dart` - Main navigation interface
- `cow_characteristics_page.dart` - Input screen for cow details
- `feed_formula_page.dart` - Feed planning interface

## Testing

The project includes comprehensive unit tests covering core functionality. Run tests with:
```
flutter test
```

## Acknowledgments

- Developed as part of the [CSARIDE (Climate Smart Agriculture Research and Innovation Support for Dairy Value Chains in Eritrea) project](https://www.csaride.org/)
- Based on validated feeding calculations provided by dairy nutrition experts

---

*For questions or support, please contact somtochiumeh@gmail.com*