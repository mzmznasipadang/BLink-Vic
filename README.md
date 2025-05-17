![BLink-Vic App Banner](For%20Github.png)

# BLink-Vic



BLink-Vic is a modern iOS application designed to help users navigate the BSD Link (BSD City, Indonesia) bus system with ease. The app provides real-time route search, bus stop information, and seamless integration with iOS features like Shortcuts and Spotlight.

---

## 🚍 Project Overview
BLink-Vic aims to make public transportation in BSD City more accessible and user-friendly. With a beautiful SwiftUI interface, live search, and AppIntents support, users can quickly find routes, scan bus plates, and get directions.

---

## ✨ Features
- **Route Search:** Find the best BSD Link bus routes between any two points.
- **Live Search & Suggestions:** Autocomplete for locations and destinations.
- **Route Details:** View stops, estimated times, and route highlights.
- **Plate Scanner:** Scan bus plates to identify and match routes (VisionKit integration).
- **Shortcuts & Spotlight:** Use AppIntents to trigger search or open results from Siri, Shortcuts, or Spotlight.
- **Onboarding & Splash:** Friendly onboarding for new users.
- **Profile & Saved Locations:** Save favorite places for quick access.
- **Modern UI:** Built with SwiftUI, MapKit, and SwiftData for a smooth experience.

---

## 📁 Folder Structure
```
BLink-Vic/
├── AppIntents/           # AppIntents extension for Shortcuts/Spotlight
├── BLink-Vic/            # Main app source (SwiftUI, assets)
│   └── Assets.xcassets/  # App icons, colors, images
├── Features/             # Main app features (Home, Search, Profile, etc.)
│   ├── AppNavigation/
│   ├── Home/
│   ├── Profile View/
│   ├── Route Result/
│   ├── RouteCard/
│   ├── Scan View TODO/
│   ├── Search/
│   ├── Splash + OB/
│   └── The Important Stuff/
├── BLink-Vic.xcodeproj/  # Xcode project files
└── readme.md             # This file
```

---

## 🛠️ Setup & Installation
1. **Clone the repository:**
   ```sh
   git clone https://github.com/yourusername/BLink-Vic.git
   cd BLink-Vic
   ```
2. **Open in Xcode:**
   - Open `BLink-Vic.xcodeproj` in Xcode 14 or later.
3. **Set the correct scheme:**
   - Choose `BLink-Vic` for the main app, or `AppIntents` for the extension.
4. **Build & Run:**
   - Requires iOS 16.0+ (iOS 18+ recommended for latest features).
   - Run on a real device for best results (some features may not work in Simulator).

---

## 🚦 Usage
- **Search for routes:** Use the Home screen to search for your destination and view matching routes.
- **Scan bus plates:** Use the Scan feature to identify buses and their routes.
- **Shortcuts/Spotlight:** Add BLink-Vic actions to Siri or Shortcuts for quick access.
- **Save locations:** Mark your favorite places for easy navigation.

---

## 🤝 Contributing
Contributions are welcome! To contribute:
1. Fork this repository.
2. Create a new branch (`git checkout -b feature/your-feature`)
3. Commit your changes (`git commit -am 'Add new feature'`)
4. Push to the branch (`git push origin feature/your-feature`)
5. Open a Pull Request.

---

## 📄 License
This project is licensed under the MIT License. See [LICENSE](LICENSE) for details.

---

## 🙏 Credits
- BSD Link, BSD City, Indonesia
- Apple (Swift, SwiftUI, MapKit, AppIntents)
- Our Fav Mentors at GOP-ADA
- All contributors and testers

---

## 📬 Contact
For questions, suggestions, or support, please open an issue or contact the maintainer.
