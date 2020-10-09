# Simple Weather App based on TDD Clean Architecture

This is my Flutter project to demonstrate Test Driven Development Clean Architecture as proposed by Reso Coder.
There are 3 layers in this architecture:

1. Data
2. Domain
3. Presentation

In this architecture, the Data layer and Presentation layer can only communicate with each other with the help of Domain Layer.

The Data layer is composed of data sources (i.e. local or remote), models, and repositories.

The Domain layer is the middle layer which is composed of entities, use cases (or business logic), and repositories.

The Presentation layer is where the UI is. This is composed of the widgets, pages, and bloc (for state management).

We also have an injection_container that centralizes our multiple services for dependency injection.

The injection_container is initialized on the main() in the main.dart file ("await dependencyInjection.init();");

With Test Driven Development, we ensure that our tests passes first before we implement the feature in our app.

## How to run this project?

Here are the steps to run this project:

1. Clone the repository. You may click "Download as ZIP" to download the project in ZIP format and then extract it afterwards.
2. Open the extracted folder named "simple_weather_app-master". You should see core files inside (i.e. lib, ios, test, pubxpec.yaml, etc.)
3. Inside the extracted folder named "simple_weather_app-master" which contains the core files, open the terminal and run "flutter pub get" to get install the dependencies.
4. Open the project in Android Studio of Visual Studio Code and run your emulator. After that, you can now start debugging this project.

## How to get started in Flutter?

A few resources to get you started if this is your first Flutter project:

-   [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
-   [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
