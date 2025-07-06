# Job Listing App

This is the Flutter based Job Listing Mobile App.

---

## **Setup Instructions**

1. Clone the repository:

2. Install dependencies:
    flutter pub get

3. Start the app: 
    flutter run

Build the app for production:
    flutter build apk

---

### Architecture Overview

- data/ – data models.
- presentation/ – contains the screens and UI widgets.
- blocs/ – handles the logic (like fetching jobs, managing favorites).
- services/ – handles API calls.

---

### State Management

This app uses BLoC (Business Logic Component) to manage app state.
- JobListBloc - fetches jobs from the API (https://mockapi.io/)
- FavoriteJobsBloc - saves and shows favorite jobs using SharedPreferences.

---

#### Time Taken
I finished this project in about 4 hours.