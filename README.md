# Stape sGTM Flutter SDK

## Overview

Stape sGTM SDK implements two main functional parts.

First is a simple event sending which allows to compose an event and send it to Stape Data Client.

SDK API provides a response from the Data Client mapped to a simple model that contains serialized response fields.

Second is a mechanism that tracks events dispatched by the Firebase event SDK.

It hooks Firebase event dispatch and maps Firebase event to Stape Data Client.

After that, it sends it as an ordinary event.

## Usage

### Installation

To include the Stape sGTM SDK in your Flutter project, add the following dependency to your pubspec.yaml file:
```yaml
dependencies:
  stape_sdk: ^1.0.0
```
Ensure you are using the latest version of the Stape sGTM SDK for Flutter.

### Initialization

To use the Stape SDK, you need to create an instance of the `Stape` class.

The instance can be created using the `Stape.withOption` method.

The method takes an `Options` object as a parameter.

```dart
import 'package:stape_sdk/stape_sdk.dart';

final Stape stape = Stape.withOption(StapeOptions(domain: "yourdomain.com"));
```

The `Options` object contains data for correct SDK initialization and requires only one
parameter - `domain`.

The `domain` parameter is a domain name of your sGTM container instance.

Do not include `https://` or `http://` schemas.

Please do not override the default `Options` values if you are not sure what you are doing.

### Sending events

After the Stape instance is created, you can send events to the Stape Data Client.

Stape SDK allows sending data in a couple of ways:

- Using a Map<String, dynamic> collection;
- Using an EventData class.

These two ways are equivalent, and you can use any of them:

```dart
stape.sendEvent("event1", {"userId": "cdd1eac3e254", "language": "en"});
stape.sendEventData("event2", EventData(userId: "cdd1eac3e254", language: "en"));
```

Please extend the `EventData` class if you need to send any other data.

### Tracking Firebase events

Stape SDK allows to decorate Firebase Analytics instance and deliver all sent events to the Stape Data Client as well.

For this purpose you need to use `FirebaseAnalyticsAdapter` class.

```dart
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:stape_sdk/stape_sdk.dart';

final Stape stape = Stape.withOption(StapeOptions(domain: "yourdomain.com"));
final FirebaseAnalytics firebaseAnalytics = FirebaseAnalytics.instance;
final analytics = FirebaseAnalyticsAdapter(stape, firebaseAnalytics);

// Sending events
analytics.logEvent(name: "event3", parameters: {"userId": "cdd1eac3e254", "language": "en"});
```

The `FirebaseAnalyticsAdapter` provides absolutely the same API as the Firebase Analytics instance.

It means that you can replace the provided types without a lot of changes.

## Trying sample app

If you desire to try the sample app, please follow the next steps:

1. Clone the repository;
2. Open the project in Android Studio;
3. Create a Firebase project with enabled Analytics;
4. Generate your own `google-services.json` file and put it into the `app` folder;
5. Create `stape.properties` file in the `app` folder and put your Stape domain name into it as a
   value for `stape.url` property. Example: ```server.host=yourdomain.com```;
6. Rebuild the app.

## License

See [LICENSE](LICENSE) for more details.
