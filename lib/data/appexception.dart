class AppExceptions implements Exception {
  final _message;
  final _prifix;
  AppExceptions([this._message, this._prifix]);

  @override
  String toString() {
    return '$_message$_prifix';
  }
}

class InternetExceptions extends AppExceptions {
  InternetExceptions([String? message]) : super(message, 'No Internet');
}

class RequestTimeOut extends AppExceptions {
  RequestTimeOut([String? message]) : super(message, 'Request Time Out');
}

class ServerExceptions extends AppExceptions {
  ServerExceptions([String? message]) : super(message, 'Internal Server error');
}

class InvalidException extends AppExceptions {
  InvalidException([String? message]) : super(message, 'Invalid Url');
}

class FetchDataException extends AppExceptions {
  FetchDataException([String? message]) : super(message, 'Error occured while communicating with server');
}


