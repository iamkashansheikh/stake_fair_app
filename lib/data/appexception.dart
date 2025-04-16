class AppExceptions implements Exception {
  final String? _message;
  final String? _prefix;

  AppExceptions([this._message, this._prefix]);

  @override
  String toString() {
    return '$_prefix: $_message';
  }
}

class InternetExceptions extends AppExceptions {
  InternetExceptions([String? message]) : super(message, 'No Internet');
}

class RequestTimeOut extends AppExceptions {
  RequestTimeOut([String? message]) : super(message, 'Request Timeout');
}

class ServerExceptions extends AppExceptions {
  ServerExceptions([String? message]) : super(message, 'Internal Server Error');
}

class InvalidException extends AppExceptions {
  InvalidException([String? message]) : super(message, 'Invalid URL');
}

class FetchDataException extends AppExceptions {
  FetchDataException([String? message]) : super(message, 'Fetch Error');
}
