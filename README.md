<div align="center">

# 🏟️ Playspace - Game Zone Booking App

![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)
![Firebase](https://img.shields.io/badge/Firebase-FFCA28?style=for-the-badge&logo=firebase&logoColor=black)

**Seamless online booking platform for indoor games, turf, trampoline, VR experiences, and PC gaming hubs**

[View Live Demo](https://sivx-folio.netlify.app/flu1#overview) • [Report Bug](https://github.com/siva-sundar-08/playspace/issues) • [Request Feature](https://github.com/siva-sundar-08/playspace/issues)

</div>

---

## 📋 Table of Contents

- [About The Project](#about-the-project)
- [Features](#features)
- [Tech Stack](#tech-stack)
- [Getting Started](#getting-started)
- [How It Works](#how-it-works)
- [App Screenshots](#app-screenshots)
- [Project Structure](#project-structure)
- [Contributing](#contributing)
- [License](#license)
- [Contact](#contact)

---

## 🎯 About The Project

**Playspace** is a comprehensive mobile solution designed to simplify the reservation process for various indoor gaming and sports facilities. Built with Flutter and powered by Firebase, this cross-platform application enables users to discover, book, and pay for recreational activities in real-time.

The app features an intuitive interface with interactive facility maps, real-time availability tracking, secure payment integration, and personalized user profiles. Playspace streamlines the booking experience for both users and facility managers, reducing administrative overhead while maximizing venue utilization.

### 🎮 Available Facilities

- 🏈 **Indoor Turf** - Football, cricket, and team sports
- 🎮 **Gaming Hubs** - High-end PC gaming stations
- 🥽 **VR Experiences** - Immersive virtual reality sessions
- 🤸 **Trampoline Parks** - Jump sessions and fitness classes

---

## ✨ Features

### 🔍 Venue Discovery
- Explore available venues categorized by type
- Detailed information and photos for each facility
- Interactive facility maps with location services

### 📅 Real-Time Booking
- Instant slot reservation with live availability updates
- Real-time calendar with pricing information
- Visual navigation of venues

### 💳 Secure Payments
- Integrated payment gateway with multiple options
- Credit/debit cards and digital wallets
- In-app credits system
- Booking confirmation with QR code

### 🔔 Smart Notifications
- Automated booking reminders
- Push notifications for updates
- Special offers and promotions

### 👤 User Management
- Personalized user profiles
- Booking history tracking
- Options to modify or cancel bookings
- Firebase authentication with multiple sign-in methods

---

## 🛠️ Tech Stack

### Frontend
- **Flutter** - Cross-platform UI toolkit for building natively compiled applications
- **Dart** - Client-optimized programming language for fast apps

### State Management
- **Provider** - State management solution for maintaining application state

### Backend & Services
- **Firebase Authentication** - Secure user authentication with multiple sign-in methods
- **Firebase Firestore** - NoSQL database for real-time data synchronization
- **Firebase Cloud Messaging** - Push notification service for reminders and updates
- **Google Maps API** - Integration for facility mapping and location services

---

## 🚀 Getting Started

### Prerequisites

Before you begin, ensure you have the following installed:
- Flutter SDK (3.0 or higher)
- Dart SDK
- Android Studio / VS Code with Flutter extensions
- Git

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/siva-sundar-08/playspace.git
   cd playspace
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Set up Firebase**
   - Create a new Firebase project at [Firebase Console](https://console.firebase.google.com/)
   - Add your Android/iOS app to the Firebase project
   - Download and add the configuration files:
     - `google-services.json` for Android (place in `android/app/`)
     - `GoogleService-Info.plist` for iOS (place in `ios/Runner/`)

4. **Configure Google Maps API**
   - Get your API key from [Google Cloud Console](https://console.cloud.google.com/)
   - Add the API key to:
     - Android: `android/app/src/main/AndroidManifest.xml`
     - iOS: `ios/Runner/AppDelegate.swift`

5. **Run the app**
   ```bash
   flutter run
   ```

---

## 📱 How It Works

### 1. **Explore Venues**
Users can browse through available venues categorized by activity type, view detailed information, photos, and facility amenities.

### 2. **Check Availability**
Real-time calendar displays available time slots with transparent pricing information for selected facilities and dates.

### 3. **Book Your Slot**
- Select preferred time slot
- Add optional services (equipment rental, coaching, etc.)
- Review and confirm booking details

### 4. **Make Payment**
Secure payment processing with multiple options including cards, digital wallets, and in-app credits.

### 5. **Receive Confirmation**
- Get booking confirmation with unique QR code
- Receive automated reminders before the event
- Access options to modify or cancel bookings anytime

---

## 📸 App Screenshots

```
[Add your app screenshots here]
```

---

## 📁 Project Structure

```
playspace/
├── analysis_options.yaml
├── pubspec.yaml
├── README.md
├── FILE_STRUCTURE.md
│
├── assets/
│   └── (images, fonts, and other resources)
│
├── lib/
│   ├── main.dart
│   └── screens/
│       ├── auth/
│       │   ├── bookings_screen.dart
│       │   ├── explore_screen.dart
│       │   ├── forgot_password_screen.dart
│       │   ├── home_screen.dart
│       │   ├── login_screen.dart
│       │   ├── notification_screen.dart
│       │   ├── profile_screen.dart
│       │   ├── settings_screen.dart
│       │   └── signup_screen.dart
│       └── venues/
│           └── venue_booking_screen.dart
│
├── test/
│   └── widget_test.dart
│
├── android/
│   ├── build.gradle.kts
│   ├── gradle.properties
│   ├── settings.gradle.kts
│   ├── gradle/
│   │   └── wrapper/
│   │       └── gradle-wrapper.properties
│   └── app/
│       ├── build.gradle.kts
│       └── src/
│           ├── debug/
│           ├── main/
│           └── profile/
│
├── ios/
│   ├── Flutter/
│   │   ├── AppFrameworkInfo.plist
│   │   ├── Debug.xcconfig
│   │   └── Release.xcconfig
│   ├── Runner/
│   │   ├── AppDelegate.swift
│   │   ├── Info.plist
│   │   ├── Runner-Bridging-Header.h
│   │   ├── Assets.xcassets/
│   │   │   ├── AppIcon.appiconset/
│   │   │   └── LaunchImage.imageset/
│   │   └── Base.lproj/
│   │       ├── LaunchScreen.storyboard
│   │       └── Main.storyboard
│   ├── Runner.xcodeproj/
│   │   ├── project.pbxproj
│   │   ├── project.xcworkspace/
│   │   │   └── contents.xcworkspacedata
│   │   └── xcshareddata/
│   ├── Runner.xcworkspace/
│   │   └── contents.xcworkspacedata
│   └── RunnerTests/
│       └── RunnerTests.swift
│
├── macos/
│   ├── Flutter/
│   │   ├── Flutter-Debug.xcconfig
│   │   ├── Flutter-Release.xcconfig
│   │   └── GeneratedPluginRegistrant.swift
│   ├── Runner/
│   │   ├── AppDelegate.swift
│   │   ├── DebugProfile.entitlements
│   │   ├── Info.plist
│   │   ├── MainFlutterWindow.swift
│   │   ├── Release.entitlements
│   │   ├── Assets.xcassets/
│   │   ├── Base.lproj/
│   │   └── Configs/
│   ├── Runner.xcodeproj/
│   │   ├── project.pbxproj
│   │   └── project.xcworkspace/
│   ├── Runner.xcworkspace/
│   │   └── contents.xcworkspacedata
│   └── RunnerTests/
│       └── RunnerTests.swift
│
├── linux/
│   ├── CMakeLists.txt
│   ├── flutter/
│   │   ├── CMakeLists.txt
│   │   ├── generated_plugin_registrant.cc
│   │   ├── generated_plugin_registrant.h
│   │   └── generated_plugins.cmake
│   └── runner/
│       ├── CMakeLists.txt
│       ├── main.cc
│       ├── my_application.cc
│       └── my_application.h
│
├── windows/
│   ├── CMakeLists.txt
│   ├── flutter/
│   │   ├── CMakeLists.txt
│   │   ├── generated_plugin_registrant.cc
│   │   ├── generated_plugin_registrant.h
│   │   └── generated_plugins.cmake
│   └── runner/
│       ├── CMakeLists.txt
│       ├── flutter_window.cpp
│       ├── flutter_window.h
│       ├── main.cpp
│       ├── resource.h
│       ├── runner.exe.manifest
│       ├── Runner.rc
│       ├── utils.cpp
│       ├── utils.h
│       ├── win32_window.cpp
│       ├── win32_window.h
│       └── resources/
│
└── web/
    ├── index.html
    ├── manifest.json
    └── icons/
```

---

## 🤝 Contributing

Contributions are what make the open-source community such an amazing place to learn, inspire, and create. Any contributions you make are **greatly appreciated**.

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

---

## 📄 License

Distributed under the MIT License. See `LICENSE` for more information.

---

## 📞 Contact

**Siva Sundar**

[![Portfolio](https://img.shields.io/badge/Portfolio-FF5722?style=for-the-badge&logo=google-chrome&logoColor=white)](https://sivx-folio.netlify.app)
[![LinkedIn](https://img.shields.io/badge/LinkedIn-0077B5?style=for-the-badge&logo=linkedin&logoColor=white)](https://www.linkedin.com/in/siva-sundar-g-b0636225a/)
[![Email](https://img.shields.io/badge/Email-D14836?style=for-the-badge&logo=gmail&logoColor=white)](mailto:sivasundar5944@gmail.com)
[![GitHub](https://img.shields.io/badge/GitHub-181717?style=for-the-badge&logo=github&logoColor=white)](https://github.com/siva-sundar-08)

**Project Link:** [https://github.com/siva-sundar-08/playspace](https://github.com/siva-sundar-08/playspace)

---

<div align="center">

### ⭐ If you found this project helpful, please give it a star!

Made with ❤️ by [Siva Sundar](https://github.com/siva-sundar-08)

</div>
