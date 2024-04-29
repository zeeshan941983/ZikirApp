# Zikir App

The Zikir App is a mobile application built with Flutter and Firebase, designed to facilitate group zikir (remembrance) sessions. It allows users to create and join zikir rooms where they can collectively perform and track their zikir counts. Additionally, the app supports offline zikir with translations and benefits available in both Urdu and English, and it utilizes SharedPreferences to save the total and current zikir counts.

## Features

- Create Zikir Rooms: Leaders can create zikir rooms and invite participants to join.
- Real-time Zikir Count Tracking: The app dynamically calculates and displays the total zikir count for all participants in the room, using Firebase's real-time capabilities.
- Offline Zikir with Translation: Users can perform zikir offline with translations available in Urdu and English.
- Zikir Benefits: The app provides the benefits of each zikir in both Urdu and English.
- SharedPreferences Support: The app uses SharedPreferences to save the total and current zikir counts for offline use.
- Room Details: The app provides details of each zikir room, including the leader's name, room ID, and the total zikir count.

## Technologies Used:

**Client:** Flutter

**Server:** Firebase, FirebaseAuth, Firebase Firestore

## Installation

To get started with the Zikir App:

- Clone the repository:

```bash
  git clone https://github.com/zeeshan941983/ZikirApp.git
```

- Navigate to the project directory:

```bash
  cd ZikirApp
```

- Install the dependencies:

```bash
  flutter pub get
```

- Run the app:

```bash
  flutter run
```
