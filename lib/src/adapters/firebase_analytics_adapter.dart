import 'package:firebase_analytics/firebase_analytics.dart';

import '../models/event_data.dart';
import '../stape.dart';

class FirebaseAnalyticsAdapter {
  final Stape _stape;
  final FirebaseAnalytics _firebaseAnalytics;
  String? _userId;
  final Map<String, String> _userProperties = {};
  Map<String, dynamic>? _defaultParameters;

  FirebaseAnalyticsAdapter(this._stape, this._firebaseAnalytics);

  void setUserId(String? userId) {
    _firebaseAnalytics.setUserId(id: userId);
    _userId = userId;
  }

  void setUserProperty(String name, String value) {
    _firebaseAnalytics.setUserProperty(name: name, value: value);
    _userProperties[name] = value;
  }

  Future<void> setConsent({bool? adStorageConsentGranted, bool? analyticsStorageConsentGranted}) {
    return _firebaseAnalytics.setConsent(
      adStorageConsentGranted: adStorageConsentGranted,
      analyticsStorageConsentGranted: analyticsStorageConsentGranted,
    );
  }

  Future<void> setAnalyticsCollectionEnabled(bool enabled) {
    return _firebaseAnalytics.setAnalyticsCollectionEnabled(enabled);
  }

  void setDefaultEventParameters(Map<String, Object?>? parameters) async {
    await _firebaseAnalytics.setDefaultEventParameters(parameters);
    _defaultParameters = parameters;
  }

  void setSessionTimeoutDuration(Duration timeout) {
    _firebaseAnalytics.setSessionTimeoutDuration(timeout);
  }

  void logEvent({
    required String name,
    Map<String, dynamic>? parameters,
  }) {
    _firebaseAnalytics.logEvent(
      name: name,
      parameters: parameters,
    );

    final payloadMap = {
      if (_defaultParameters != null) ..._defaultParameters!,
      if (parameters != null) ...parameters,
      'userId': _userId,
      'userData': _userProperties,
    };

    _stape.sendEventData(name, EventData.fromJson(payloadMap));
  }
}
