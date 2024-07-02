# flutter_template

A template Flutter mobile app project

## Getting Started

### MacOS Silicon

1. Install Flutter, following the instructions in <a href='https://docs.flutter.dev/get-started/install'>the Flutter documentation</a>.

2. Using `rvm`, install `ruby 3.3.3`. 

_Note: this is due to, at the time of writing this document, the `flutterfire configure` call mentioned below only working using ruby 3.3.3._ 

```zsh
rvm install ruby 3.3.3
rvm use ruby 3.3.3
```

## Building the app

### 1. Run the code generator

```zsh
dart run build_runner build --delete-conflicting-outputs
```

### 2. Generating the Dart localization key constants

```zsh
dart run easy_localization:generate -S assets/translations -f json -O lib/app/localization/generated -o locale_json.g.dart
dart run easy_localization:generate -S assets/translations -f keys -O lib/app/localization/generated -o locale_keys.g.dart
```

### 3. Initialise Firebase

#### 3.1 Install the Firebase CLI

**Using npm**

```zsh
npm install -g firebase-tools
```

See the following link for more details on the different ways to install firebase-tools:
https://firebaseopensource.com/projects/firebase/firebase-tools/#installation 

#### 3.2 Log in to Firebase

```zsh
firebase login
```

#### 3.3 Install FlutterFire

This is a package that simplifies the integration of Firebase into a Flutter cross-platform app.
To install it globally on your system, use:

```zsh
dart pub global activate flutterfire_cli
```

#### 3.4 Configure Firebase in your local copy of the codebase

```zsh
flutterfire configure
```

## Running the integration Tests

The integration tests are located in the `/integration_test` directory. 
They require the Firebase emulators to be running on the `localhost` in order to mock the app interfacing with the Firebase backend.

A test group is defined per 'set of features' _(such as per screen / epic)_, each in separate files.

The `integration_test_helpers.dart` file defines some helper methods to run integration tests with the app. It provides setUp and tearDown functions that can be used in the integration test `setUp` and `tearDown` methods, to initialise and tear down the app between test cases.

The `integration_test_page.dart` file defines an interface for a page in the app to perform integration test steps, and expect certain states.

Follow these steps to set up and run the integration tests.

1. Ensure you have the Firebase CLI installed, following the instructions on <a href="https://firebase.google.com/docs/cli">the Firebase docs</a>.

2. In one terminal session, open the `/firebase_app` directory.

```zsh
cd firebase_app/
```

3. Ensure the emulators are initialised

```zsh
firebase init emulators
```

4. Launch the Firebase emulators

```zsh
firebase emulators:start
```

5. In another terminal session, run the integration tests, using the helper script:

```zsh
utils/execute_integration_tests.sh
```
