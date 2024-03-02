import 'user_data.dart';

class EventData {
  String? clientId;
  String? currency;
  String? ipOverride;
  String? language;
  String? pageEncoding;
  String? pageHostname;
  String? pageLocation;
  String? pagePath;
  String? pageReferrer;
  String? pageTitle;
  String? screenResolution;
  String? userAgent;
  UserData? userData;
  String? userId;
  num? value;
  String? viewportSize;

  EventData({
    this.clientId,
    this.currency,
    this.ipOverride,
    this.language,
    this.pageEncoding,
    this.pageHostname,
    this.pageLocation,
    this.pagePath,
    this.pageReferrer,
    this.pageTitle,
    this.screenResolution,
    this.userAgent,
    this.userData,
    this.userId,
    this.value,
    this.viewportSize,
  });

  factory EventData.fromJson(Map<String, dynamic> json) => EventData(
        clientId: json['client_id'],
        currency: json['currency'],
        ipOverride: json['ip_override'],
        language: json['language'],
        pageEncoding: json['page_encoding'],
        pageHostname: json['page_hostname'],
        pageLocation: json['page_location'],
        pagePath: json['page_path'],
        pageReferrer: json['page_referrer'],
        pageTitle: json['page_title'],
        screenResolution: json['screen_resolution'],
        userAgent: json['user_agent'],
        userData: json['user_data'] != null ? UserData.fromJson(json['user_data']) : null,
        userId: json['user_id'],
        value: json['value'],
        viewportSize: json['viewport_size'],
      );

  Map<String, dynamic> toJson() => {
        'client_id': clientId,
        'currency': currency,
        'ip_override': ipOverride,
        'language': language,
        'page_encoding': pageEncoding,
        'page_hostname': pageHostname,
        'page_location': pageLocation,
        'page_path': pagePath,
        'page_referrer': pageReferrer,
        'page_title': pageTitle,
        'screen_resolution': screenResolution,
        'user_agent': userAgent,
        'user_data': userData?.toJson(),
        'user_id': userId,
        'value': value,
        'viewport_size': viewportSize,
      };
}
