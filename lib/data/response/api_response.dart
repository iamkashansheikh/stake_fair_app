
import 'package:stake_fair_app/data/response/status.dart';

class ApiResponse<T> {
  Status? status;
  T? data;
  String? message;

  ApiResponse(this.status, this.data, this.message);
  ApiResponse.loading() : status = Status.lOADING;
  ApiResponse.completed(this.data) : status = Status.cOMPLETED;
  ApiResponse.error(this.message) : status = Status.eRROR;

  @override
  String toString() {
    return "Status: $status \n Message: $message \n $data: data";
  }
}
