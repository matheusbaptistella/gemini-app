# BedTime
<img align="left" src="assets/images/logo.png" alt="BedTime logo" width="200" height="200">
<br><br><br>BedTime is an app written in Flutter and backed by Firebase. It was developed for the 2024 Gemini API Developer Competition.
BedTime uses Gemini's generative capabilities to create bedtime stories from a theme that the user can input as a string.

<br><br>

# Usage
BedTime works on Web and Android. Before running, create a `.env` file and add your Google AI Studio key there (BedTime is configured to use the Gemini 1.5 Flash MODEL):
```
API_KEY=<your_key>
```

To run on Android, simply start your emulator, select the device and run the app on release mode.
```
flutter run --release
```

To run it on a browser (Chrome was the browser used on testing), run the command:
```
flutter run --web-renderer html --release
```

Thank you very much :)
