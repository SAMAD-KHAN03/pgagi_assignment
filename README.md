# 🚀 Startup Idea Evaluator – Flutter App

A fun and interactive mobile app that lets users submit their startup ideas, receive a fake AI rating, vote on others' ideas, and view the top-rated concepts on a dynamic leaderboard.

---

## 📱 App Description

**Startup Idea Evaluator** is a Flutter-based mobile app where:
- Users can **submit startup ideas**
- The app generates a **fun AI-generated rating** (0–100)
- Users can **vote on other ideas** (1 vote per idea)
- A **leaderboard** displays the top 5 ideas based on votes or ratings

The goal is to simulate a fun, gamified environment to pitch, vote, and view innovative ideas.

---

## 🧑‍💻 Tech Stack Used

- **Flutter** (Dart)
- **State Management**: `Provider`
- **Persistent Storage**: `SharedPreferences`
- **UI**: Material Design + Custom Widgets
- **Icons/Fonts**: `GoogleFonts`, Material Icons

---

## ✨ Features Implemented

- ✅ Submit startup ideas (name, tagline, description)
- ✅ Generate and display AI rating on submission
- ✅ Store and retrieve ideas using local storage (`SharedPreferences`)
- ✅ Vote once per idea (stored locally)
- ✅ List all submitted ideas with:
  - Rating
  - Tagline
  - Description (expandable)
- ✅ Sort by rating or votes
- ✅ Leaderboard of top 5 ideas
- ✅ 🥇🥈🥉 badges and styled leaderboard cards
- ✅ Dark mode toggle
- ✅ Toast notifications on submit and vote
- ✅ Reusable widgets for text fields, headers, empty state, and buttons

---

## 🛠️ How to Run Locally or Install the APK

### ✅ Prerequisites
- Flutter SDK: [Install guide](https://docs.flutter.dev/get-started/install)
- Android Studio or VS Code
- An emulator or physical Android device
- Git (to clone the repo)

---

### 💻 Run on Android Emulator or Device

#### 1. **Clone the Project**
git clone https://github.com/SAMAD-KHAN03/pgagi_assignment
cd pgagi_assignment 

#### 2.**download dependencies
run the command-flutter pub get

#### 3.**Install on physical or emulator device
run the app using the command -flutter run
or
build the app using the command -flutter build apk --release
install the app on connected physical device using the command -flutter install
or
install the app on connected emulator device using the command -adb install build/app/outputs/flutter-apk/app-release.apk
