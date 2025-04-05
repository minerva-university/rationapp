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

## Handover Guide for NGO Staff

This section provides essential guidance for non-technical users who need to maintain and update the app after the initial development phase.

### Modifying App Content

#### Updating Text and Translations

1. **Locate the language files**: All text content is stored in the `lib/l10n` directory in `.arb` files:
   - `intl_en.arb` - English text
   - `intl_ar.arb` - Arabic text
   - `intl_ti.arb` - Tigrinya text

2. **Edit the files**: Open these files with any text editor (like Notepad, TextEdit, or Visual Studio Code). The format looks like this:
   ```json
   "concentrateSorghumGrain": "Sorghum grain",
   "@concentrateSorghumGrain": {
       "description": "Concentrate: Sorghum grain"
   },
   ```

3. **Make your changes**: 
   - Edit only the text inside the quotation marks after the key (e.g., "Sorghum grain")
   - Do not change the keys (the text before the colon, e.g., "concentrateSorghumGrain")
   - The description field helps translators understand the context
   - Make sure to maintain the JSON format with proper commas and brackets

4. **Save the files**: Save the changes and proceed to building an update.

#### Updating Feed Ingredient Information

To modify nutritional values or add new feed ingredients:

1. Open `lib/data/nutrition_tables.dart`
2. For existing ingredients, find the relevant item in either `fodderItems` or `concentrateItems` list
3. Update the nutritional values as needed
4. To add a new ingredient:
   - Add a new `FeedIngredient` entry following the existing pattern
   - Include the ID, name, and all nutritional parameters
   - Add corresponding translation keys to the `.arb` files

### Building and Distributing Updates

Once you've made your content changes, you'll need to build and distribute the updated app:

#### Prerequisites

1. **Install Flutter**: Follow the [Flutter installation guide](https://docs.flutter.dev/get-started/install)
2. **Install Visual Studio Code**: Download from [code.visualstudio.com](https://code.visualstudio.com/download)
3. **Install Git**: Download from [git-scm.com](https://git-scm.com/downloads)

#### Building the App

1. **Get the code**:
   ```
   git clone https://github.com/minerva-university/rationapp.git
   cd rationapp
   ```

2. **Install dependencies**:
   ```
   flutter clean
   flutter pub get
   ```

3. **Build the APK** (for Android):
   ```
   flutter build apk
   ```
   The APK will be located at `build/app/outputs/flutter-apk/app-release.apk`

#### Distributing the Update

For regions with limited connectivity, use these methods to distribute updates:

1. **Direct APK sharing**: Provide the APK file to extension officers via:
   - USB drives (most common method)
   - Email (where internet is available)
   - Bluetooth transfer

2. **Installation instructions for extension officers**:
   - Copy the APK file to the farmer's phone
   - Navigate to the file using a file manager
   - Tap the APK file to install (may need to enable "Install from Unknown Sources" in settings)
   - If updating an existing installation, the app data will be preserved

#### Creating User Guides

When distributing updates, consider providing:

1. **Change summary**: A simple document explaining what has changed in the new version
2. **Visual guides**: Screenshots showing new features or modified screens
3. **Training sessions**: Brief in-person demonstrations for extension officers

## Setup Instructions for Developers

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