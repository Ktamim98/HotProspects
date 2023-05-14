# HotProspects
HotProspects is a simple iOS app that allows users to generate a QR code containing their name and email address, which others can scan to quickly add them as a contact. The app uses SwiftUI for its user interface and Core Image for generating the QR code, toggle whether they have contacted the person represented by the code, and receive notifications on their lock screen. The app also includes a code scanner package and swipe gestures to show notification alerts.

## Features
- Generate a QR code based on user-provided name and email address
- Save the generated QR code to the photo library
- Toggle whether the user has contacted the person represented by the code
- Receive notifications on the lock screen
- Code scanner package
- Swipe gestures to show notification alerts

## Technologies Used
- Swift
- SwiftUI
- CoreImage framework
- CoreImage.CIFilterBuiltins module
- NotificationCenter framework
- UserNotifications framework
- CodeScanner package by Paul Hudson

## Usage
On the home screen, the user can enter their name and email address in the text fields provided. The app will generate a QR code based on the user's input. The user can then tap and hold on the QR code to save it to their photo library.
To mark a contact as contacted or uncontacted, the user can swipe left or right on the contact's row in the list view. A notification alert will appear to confirm the change.
When the user locks their screen, they will receive a notification reminding them to contact any uncontacted contacts. Tapping on the notification will open the app and display the list of contacts.
To scan a QR code, the user can tap on the "Scan Code" button at the bottom of the home screen. This will open the code scanner package provided by Paul Hudson. Once the code is successfully scanned, the app will navigate to a detail view displaying the name and email address associated with the code.


## Code Overview
### Prospect Class
- The Prospect class defines the structure of a contact in the app. It contains an id, a name, an email address, and a boolean isContacted to indicate whether the contact has been contacted or not.

### Prospects Class
- The Prospects class is an ObservableObject that stores an array of Prospect objects. It provides methods to add new contacts and toggle the isContacted flag. It also uses UserDefaults to persist the contacts between app sessions.

### MeView Struct
- The MeView struct defines the main view of the app. It contains three @State variables for the name, email address, and generated QR code image. It uses a CIContext and CIFilter.qrCodeGenerator() to generate the QR code image. The updateCode() function is called whenever the name or email address is changed to regenerate the QR code image. The view also provides a context menu to save the generated QR code to the photo library.

### ImageSaver Class
- The ImageSaver class provides a helper method to save an image to the photo library. It uses the UIImageWriteToSavedPhotosAlbum() method to save the image.

## Credits
CodeScanner package by Paul Hudson and this app is also part of "100 Days of SwiftUi" course.

