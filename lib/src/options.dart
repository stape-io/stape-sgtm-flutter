class StapeOptions {
  String domain;
  String? requestPath;
  int? protocolVersion;
  bool? richsstsse;

  StapeOptions({
    required this.domain,
    this.requestPath = '/data',
    this.protocolVersion = 2,
    this.richsstsse = false,
  });

  factory StapeOptions.fromJson(Map<String, dynamic> json) {
    return StapeOptions(
      domain: json['gtm_server_domain'],
      requestPath: json['request_path'],
      protocolVersion: json['protocol_version'],
      richsstsse: json['richsstsse'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'gtm_server_domain': domain,
      'request_path': requestPath,
      'protocol_version': protocolVersion,
      'richsstsse': richsstsse,
    };
  }
}
