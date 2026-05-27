# 💰 Money Bender

> A cross-platform mobile app for personal finance and daily expense tracking, built with Flutter and Firebase.

![Status](https://img.shields.io/badge/status-in%20development-yellow)
![Platform](https://img.shields.io/badge/platform-iOS%20%7C%20Android%20%7C%20Web%20%7C%20Desktop-blue)
![Flutter](https://img.shields.io/badge/Flutter-3.x-02569B?logo=flutter)
![Firebase](https://img.shields.io/badge/Firebase-Backend-FFCA28?logo=firebase)

---

## 📖 About the Project

**Money Bender** is a personal finance application that helps users track daily expenses, monitor spending patterns, and build healthier financial habits.

Built as a personal project to explore cross-platform mobile development with Flutter, real-time backend services with Firebase, and secure handling of user financial data.

> ⚠️ **Status:** Active development paused during the current university exam session. Development will resume after the exam period, with the features listed in the roadmap below.

---

## ✨ Features

### ✅ Implemented
- 🔐 **Secure user authentication** via Firebase Authentication
- 💸 **Expense tracking** — log daily transactions with categories
- ☁️ **Real-time data sync** across devices via Cloud Firestore
- 👤 **Per-user data isolation** — each user only accesses their own data
- 📱 **Cross-platform support** — iOS, Android, Web, Windows, macOS, Linux

### 🚧 In Development
- 📊 Analytics dashboard with spending charts and trends
- 🎯 Monthly budget setting and tracking
- 🔔 Notifications for budget thresholds
- 📤 Data export (CSV / PDF)
- 🌙 Dark mode

---

## 🔒 Security Considerations

As a Cybersecurity student, particular attention was given to security best practices in the app design:

- **Authentication**: handled exclusively via Firebase Auth (no custom credential management)
- **Firestore Security Rules**: each user can read and write only documents associated with their own UID
- **Sensitive credentials**: Firebase configuration files (`google-services.json`, `GoogleService-Info.plist`, `firebase_options.dart`) are excluded from version control via `.gitignore`
- **No hardcoded secrets**: API keys and configuration are loaded from environment-specific files at build time

> ✅ Verified clean: this repository contains **no leaked secrets, credentials, or service account keys**.

---

## 🛠️ Tech Stack

| Layer            | Technology                         |
|------------------|------------------------------------|
| Framework        | Flutter (Dart)                     |
| Backend          | Firebase                           |
| Authentication   | Firebase Authentication            |
| Database         | Cloud Firestore (NoSQL)            |
| Platforms        | iOS, Android, Web, Windows, macOS, Linux |

---

## 🚀 Getting Started

### Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started/install) (3.x or higher)
- [Dart SDK](https://dart.dev/get-dart) (3.x or higher)
- A Firebase project ([console.firebase.google.com](https://console.firebase.google.com/))
- [FlutterFire CLI](https://firebase.flutter.dev/docs/cli/) for Firebase configuration

### Installation

```bash
# Clone the repository
git clone https://github.com/Minanoukola/moneybender.git
cd moneybender

# Install Flutter dependencies
flutter pub get
```

### Firebase Configuration

Since Firebase config files are excluded from the repo (for security), you need to generate your own:

```bash
# Install FlutterFire CLI (if not already installed)
dart pub global activate flutterfire_cli

# Configure Firebase for this project
flutterfire configure
```

This will generate:
- `android/app/google-services.json`
- `ios/Runner/GoogleService-Info.plist`
- `macos/Runner/GoogleService-Info.plist`
- `lib/firebase_options.dart`

### Run the application

```bash
# Run on the default connected device
flutter run

# Run on a specific platform
flutter run -d chrome      # Web
flutter run -d macos       # macOS
flutter run -d windows     # Windows
```

---

## 📁 Project Structure

```
moneybender/
├── lib/                  # Dart source code
├── android/              # Android-specific code
├── ios/                  # iOS-specific code
├── macos/                # macOS-specific code
├── windows/              # Windows-specific code
├── linux/                # Linux-specific code
├── web/                  # Web-specific code
├── test/                 # Unit and widget tests
├── firebase.json         # Firebase project configuration
├── pubspec.yaml          # Flutter dependencies
└── .gitignore            # Excludes secrets and build artifacts
```

---

## 🗺️ Roadmap

- [x] Project setup and multi-platform configuration
- [x] Firebase Authentication integration
- [x] Basic expense tracking
- [x] Cloud Firestore sync
- [ ] Analytics dashboard with charts
- [ ] Monthly budget system
- [ ] Push notifications
- [ ] Data export (CSV / PDF)
- [ ] Dark mode support
- [ ] Unit and integration test coverage

---

## 👤 Author

**Mina Noukola** — Cybersecurity Student @ Università degli Studi di Milano

- 🔗 LinkedIn: [linkedin.com/in/minanoukola](https://www.linkedin.com/in/minanoukola)
- 📧 Email: minanoukola02@gmail.com
- 🐙 GitHub: [@Minanoukola](https://github.com/Minanoukola)

---

## 📄 License

This project is currently developed as a personal/educational project. All rights reserved.

> If you would like to use this code for educational or non-commercial purposes, feel free to open an issue or reach out.
