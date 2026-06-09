# Soccer GG Predictor

A sleek, cross-platform Flutter application designed to predict the probability of a "Goal Goal" (GG) outcome in soccer matches, meaning both teams score at least one goal.

## Features

*   **Match Analysis Form:** Input the home and away team names.
*   **Tactical Ratings:** Use intuitive sliders to rate the attacking and defensive strengths of both teams on a scale of 1-10.
*   **Probability Algorithm:** Calculates the estimated probability of both teams scoring based on the provided tactical ratings.
*   **Instant Results:** Displays the percentage chance of a GG outcome along with a contextual analysis message.
*   **Responsive Design:** Works seamlessly across mobile, tablet, and desktop devices.
*   **Theme Support:** Automatically adapts to the system's light or dark mode.

## User Flows

1.  **Enter Match Details:** The user opens the app and enters the names of the competing home and away teams.
2.  **Adjust Ratings:** The user adjusts the attack and defense sliders for both teams based on their real-world form or subjective analysis.
3.  **Generate Prediction:** The user taps "Calculate GG Probability".
4.  **View Outcome:** The app displays a detailed card showing the percentage probability of both teams scoring, along with a brief analysis.

## Tech Stack

*   Framework: Flutter
*   Language: Dart
*   Design System: Material 3

## Setup & Run Instructions

1.  Ensure you have the [Flutter SDK](https://docs.flutter.dev/get-started/install) installed and configured.
2.  Clone the repository and navigate to the project directory.
3.  Install dependencies:
    ```bash
    flutter pub get
    ```
4.  Run the application on your preferred device or emulator:
    ```bash
    flutter run
    ```

---

## About CouldAI

This application was generated with [CouldAI](https://could.ai), an AI app builder for cross-platform apps that turns prompts into real native iOS, Android, Web, and Desktop apps with autonomous AI agents that architect, build, test, deploy, and iterate production-ready applications.
