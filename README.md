# Automobile Management System

An Automobile Management System to buy and sell parts made with Flutter.

## Description

This project is an automobile parts marketplace where vendors can list and sell parts. When a customer searches for parts, vendors can make offers with their parts, and users can accept the best offers within a limited time.

### Features

- Users and Vendors can chat with each other.
- Users can follow each other.
- When a user searches for a product, a notification is sent to the vendor they follow. If the vendor has the part, they will offer it with a price. The offer is shown to the user for a limited time, which the user can accept or reject.
- Nearby feature where users can see nearby vendors on a map in real-time.

## Installation

To run this project, follow these steps:

1. Clone the repository:
   ```bash
   git clone https://github.com/Mahad871/automobile_management.git
   ```
2. Navigate to the project directory:
   ```bash
   cd automobile_management
   ```
3. Install the dependencies:
   ```bash
   flutter pub get
   ```
4. Run the application:
   ```bash
   flutter run
   ```

## Usage

- **Search for Parts**: Users can search for automobile parts and receive offers from vendors.
- **Chat with Vendors**: Users can chat with vendors to negotiate or inquire about parts.
- **Follow Vendors**: Users can follow vendors to get notified about new parts and offers.
- **View Nearby Vendors**: Users can see vendors near their location on a map in real-time.

## Repository Structure
```plaintext
automobile_management/
├── android/                # Android-specific files
├── assets/                 # Contains images and other static assets
├── ios/                    # iOS-specific files
│   ├── Runner/
│   └── Assets.xcassets/
├── lib/                    # Main source code
│   ├── models/             # Data models
│   ├── screens/            # UI screens
│   ├── services/           # Backend services and API calls
│   ├── utils/              # Utility functions
│   └── main.dart           # Entry point of the application
├── test/                   # Unit and widget tests
├── .gitignore              # Git ignore file
├── pubspec.yaml            # Dart package configuration
└── README.md               # Project documentation
```

## Contributing

Contributions are welcome! Please follow these steps:

1. Fork the repository.
2. Create a new branch:
   ```bash
   git checkout -b feature/your-feature-name
   ```
3. Make your changes and commit them:
   ```bash
   git commit -m 'Add some feature'
   ```
4. Push to the branch:
   ```bash
   git push origin feature/your-feature-name
   ```
5. Open a pull request.

## License

This project is licensed under the MIT License.

---

Feel free to review and make any adjustments before finalizing it.
