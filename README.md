# SGReady

SGReady is a Flutter mobile application developed for my Final Year Project (FYP). It is designed to help users in Singapore stay prepared for environmental conditions such as haze, high UV levels, heat, heavy rain and flash floods.

The app uses real-time environmental data from data.gov.sg and turns the information into simple actions that users can take. Depending on the current conditions, SGReady may suggest activities such as drinking more water, applying sunscreen or preparing for rain.

Besides displaying environmental information, SGReady also includes daily preparedness tasks, educational content, quizzes, scenarios and gamification features to make preparedness more interactive.

---

## Main Features

- **Real-time environmental information** – Displays PSI, UV and rainfall information retrieved from data.gov.sg.
- **Daily preparedness tasks** – Provides activities based on current environmental conditions, such as hydration, sunscreen and rain preparation tasks.
- **Preparedness guidance** – Gives users simple recommendations based on environmental conditions.
- **Learn section** – Includes preparedness information, emergency contacts, CPR/AED guidance, quizzes and interactive scenarios.
- **Gamification** – Includes XP, levels, badges, streaks and progress tracking.
- **User accounts** – Uses Firebase Authentication for account creation, login and logout.
- **User progress** – Stores user-specific progress and preferences using Cloud Firestore.
- **Notifications** – Provides environmental preparedness and daily task reminders.
- **Multi-language support** – Supports English, Chinese and Malay.

---

## Technologies Used

SGReady was developed using:

- Flutter and Dart
- Firebase Authentication
- Cloud Firestore
- Firebase Cloud Messaging
- Firebase Cloud Functions
- Firebase Hosting
- Riverpod
- WorkManager
- data.gov.sg APIs

---

## Data Sources

Environmental information is retrieved from Singapore Government data sources through data.gov.sg.

| Data | API Endpoint |
|---|---|
| PSI | `https://api-open.data.gov.sg/v2/real-time/api/psi` |
| UV Index | `https://api-open.data.gov.sg/v2/real-time/api/uv` |
| Rainfall | `https://api-open.data.gov.sg/v2/real-time/api/rainfall` |

Dataset pages:

- PSI: https://data.gov.sg/datasets/d_fe37906a0182569d891506e815e819b7/view
- UV Index: https://data.gov.sg/datasets/d_1b676cd174a9af4704fdb3f9aa58ff5e/view
- Rainfall: https://data.gov.sg/datasets/d_6580738cdd7db79374ed3152159fbd69/view

An internet connection is required to retrieve the latest environmental data.

---

## Project Structure

Most of the application code can be found inside the `lib` folder.

```text
SGready/
│
├── lib/
│   ├── l10n/              # Language and localisation files
│   ├── models/            # Data models
│   ├── providers/         # Riverpod providers and app state
│   ├── screens/           # Application screens
│   ├── services/          # API, Firebase, progress and notification services
│   ├── theme/             # Application theme
│   ├── widget/            # Reusable widgets
│   ├── firebase_options.dart
│   └── main.dart
│
├── assets/                # Images and scenario content
├── test/                  # Automated Flutter tests
├── functions/             # Firebase Cloud Functions
├── android/
├── ios/
├── web/
├── windows/
├── linux/
├── macos/
├── pubspec.yaml
├── firebase.json
└── README.md
```

---

# How to Run the Project

The following steps can be used to run SGReady after downloading the project from GitHub.

## 1. Requirements

Before running the project, make sure the following are installed:

- Flutter SDK
- Git
- Visual Studio Code or Android Studio
- Android SDK
- An Android emulator or physical Android device

Check that Flutter is set up correctly:

```bash
flutter doctor
```

Resolve any required setup issues shown by Flutter before continuing.

## 2. Clone the Repository

Open PowerShell, Command Prompt or another terminal and run:

```bash
git clone https://github.com/Nicholas-Ho-yy/SGready.git
```

Enter the project folder:

```bash
cd SGready
```

## 3. Install Dependencies

Run:

```bash
flutter pub get
```

This installs the packages required by the project.

The Flutter platform folders are already included in the repository, so there is no need to run `flutter create`.

## 4. Firebase Setup

SGReady uses Firebase for authentication, user progress and other cloud-based features.

The local Android Firebase configuration file:

```text
android/app/google-services.json
```

is not included in the public repository.

To configure Firebase, install the FlutterFire CLI:

```bash
dart pub global activate flutterfire_cli
```

Then run the following command from the project folder:

```bash
flutterfire configure
```

Follow the FlutterFire setup instructions to configure the Firebase project.

SGReady uses Firebase Authentication, Cloud Firestore, Cloud Messaging and Cloud Functions.

## 5. Select a Device

Start an Android emulator or connect a physical Android device.

Check the devices available to Flutter:

```bash
flutter devices
```

If using a physical Android device, make sure USB debugging is enabled.

## 6. Run SGReady

Run:

```bash
flutter run
```

If more than one device is available, you can specify a device using:

```bash
flutter run -d <device-id>
```

The device ID can be found using `flutter devices`.

---

## Running the Web Version

SGReady can also be run in Chrome:

```bash
flutter run -d chrome
```

A production web build can be created using:

```bash
flutter build web
```

The generated files will be available under:

```text
build/web/
```

---

## Testing

### Static Analysis

Run:

```bash
flutter analyze
```

At the time of submission, the project completed static analysis with:

```text
No issues found!
```

### Automated Tests

Run:

```bash
flutter test
```

For a more detailed test output:

```bash
flutter test --reporter expanded
```

At the time of submission, SGReady contains five automated tests and all five pass.

The tests cover:

1. Increasing the streak on consecutive completed days.
2. Resetting the streak when a day is missed.
3. Resetting daily mission progress on a new day while keeping long-term progress.
4. Keeping progress separate between different daily tasks.
5. Recording completed daily plans in the user's history.

---

## Troubleshooting

### Flutter is not recognised

Check that Flutter has been installed and added to the system PATH, then run:

```bash
flutter doctor
```

### No device is detected

Run:

```bash
flutter devices
```

Start an Android emulator or connect a physical Android device with USB debugging enabled.

### Firebase configuration error

Make sure Firebase has been configured and, for Android, check that the following file is available locally:

```text
android/app/google-services.json
```

If required, run:

```bash
flutterfire configure
```

### Environmental data is not showing

SGReady requires an internet connection to retrieve live data from data.gov.sg. If the external service is temporarily unavailable, the latest environmental information may not be displayed.

---

## Licence

Environmental data used by SGReady is provided through data.gov.sg and is subject to the Singapore Open Data Licence.

SGReady was developed for academic purposes as part of my Final Year Project. 