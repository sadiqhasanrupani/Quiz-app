# Flutter Quiz Challenge

A responsive Flutter quiz application with local persistence, smooth animations, and comprehensive accessibility support.

## Features

### Welcome Screen
- **Clean, Modern UI**: Responsive design that adapts to different screen sizes and orientations
- **Last Score Display**: Shows previous quiz performance when available
- **Resume Functionality**: Continue interrupted quizzes from where you left off
- **Smooth Animations**: Fade-in and slide animations for enhanced user experience
- **Accessibility**: Full semantic labels and minimum 48x48dp tap targets
- **Dark Mode Support**: Follows system theme preference

### Quiz Functionality
- **Interactive Quiz Flow**: Multiple-choice questions with progress tracking
- **Local Persistence**: Save quiz progress and results using SharedPreferences
- **State Management**: Provider pattern for reactive UI updates
- **Result Tracking**: Stores last 10 quiz results with timestamps and duration

### Technical Architecture
- **Clean Architecture**: Separation of concerns with models, services, controllers, and screens
- **Provider Pattern**: Reactive state management for UI updates
- **Local Storage**: SharedPreferences abstraction through StorageService
- **Comprehensive Testing**: Widget tests with mocked dependencies

## File Structure

```
lib/
├── main.dart                     # App entry point with Provider setup
├── models/
│   ├── question.dart            # Question data model
│   └── quiz_result.dart         # Quiz result data model
├── services/
│   └── storage_service.dart     # Local persistence abstraction
├── controllers/
│   └── quiz_controller.dart     # Quiz state management
└── screens/
    ├── welcome_screen.dart      # Main welcome/home screen
    ├── quiz_screen.dart         # Quiz interaction screen
    └── result_screen.dart       # Quiz results display

test/
├── widget_test.dart            # Main app tests
└── screens/
    └── welcome_screen_test.dart # Welcome screen widget tests
```

## Dependencies

### Production Dependencies
- `provider: ^6.1.1` - State management
- `shared_preferences: ^2.2.2` - Local data persistence

### Development Dependencies
- `mockito: ^5.4.4` - Mock generation for testing
- `build_runner: ^2.4.7` - Code generation tools
- `flutter_lints: ^4.0.0` - Linting rules

## Getting Started

1. **Install Dependencies**
   ```bash
   flutter pub get
   ```

2. **Generate Mocks** (if needed)
   ```bash
   flutter packages pub run build_runner build
   ```

3. **Run Tests**
   ```bash
   flutter test
   ```

4. **Run Application**
   ```bash
   flutter run
   ```

## Key Implementation Details

### Welcome Screen Features

#### Responsive Design
- Adapts layout for tablets (>600dp width)
- Adjusts spacing and font sizes for landscape orientation
- Uses `MediaQuery` and `LayoutBuilder` for responsive behavior

#### Animations
- **Fade Animation**: App title and description fade in smoothly
- **Slide Animation**: Buttons and cards slide up from bottom
- **Hero Animation**: App icon with hero transition tag
- **AnimatedSwitcher**: Smooth transitions for conditional content

#### Accessibility
- Semantic labels on all interactive elements
- Minimum 48x48dp tap targets
- Screen reader friendly content descriptions
- High contrast support via Material 3 theming

#### State Integration
- Loads last quiz score from local storage
- Detects resume data availability
- Integrates with QuizController via Provider
- Handles loading states with visual feedback

### Storage Architecture

The `StorageService` provides a clean abstraction over SharedPreferences:
- **Last Score Persistence**: Saves and retrieves quiz results
- **Resume Data**: Stores partial quiz progress
- **Score History**: Maintains last 10 quiz results
- **Data Management**: Methods for clearing specific or all data

### Testing Strategy

#### Widget Tests
- **UI Validation**: Verifies correct widget rendering
- **State Integration**: Tests with different data scenarios
- **Navigation Testing**: Ensures proper screen transitions
- **Accessibility Testing**: Validates semantic labels
- **Responsive Testing**: Checks tablet/phone adaptations
- **Mock Integration**: Uses Mockito for isolated testing

#### Test Coverage
- Welcome screen with and without saved data
- Resume functionality validation
- Loading state handling
- Navigation flow verification
- Accessibility compliance

## Code Quality

### Architecture Principles
- **Single Responsibility**: Each class has a focused purpose
- **Dependency Injection**: Services injected through constructors
- **Testability**: All external dependencies are mockable
- **Separation of Concerns**: UI logic separated from business logic

### Performance Considerations
- **Efficient State Management**: Provider pattern prevents unnecessary rebuilds
- **Lazy Loading**: Storage service uses singleton pattern
- **Animation Optimization**: Uses appropriate animation curves and durations
- **Memory Management**: Proper disposal of animation controllers

### Accessibility Features
- **Semantic Labels**: All interactive elements have descriptive labels
- **Focus Management**: Logical tab order for keyboard navigation
- **Color Contrast**: Material 3 theming ensures sufficient contrast
- **Touch Targets**: All buttons meet minimum size requirements
- **Screen Reader Support**: Comprehensive content descriptions

## Future Enhancements

- **Question Categories**: Support for different quiz topics
- **Difficulty Levels**: Easy, medium, hard question sets
- **Leaderboard**: Global high scores with user accounts
- **Custom Themes**: Additional theme options beyond system
- **Question Timer**: Time limits for individual questions
- **Statistics Dashboard**: Detailed performance analytics
