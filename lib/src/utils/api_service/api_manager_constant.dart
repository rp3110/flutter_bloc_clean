/// APIManagerConstants
class APIManagerConstants {
  /// Here as per requirements you can add or modify content type
  static const String contentAccept = "application/json";
  static const String contentTypeJSON = "application/json";
  static const String contentTypeXFormURLEncoded =
      "application/x-www-form-urlencoded";

  /// Network failure manage
  static const String networkError =
      "No Internet Connection. Please check and try again.";
  static const String requestCancel = "Request to API server was cancelled";
  static const String connectionTimeout = "Connection timeout with API server";
  static const String receiveTimeout =
      "Receive timeout in connection with API server";
  static const String badCertificate = "Bad Certificate";
  static const String connectionError = "Connection Error";
}
