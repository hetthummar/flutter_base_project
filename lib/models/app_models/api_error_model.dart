class ApiErrorModel{

  int statusCode;
  String errorMessage;
  bool unexpectedError;

  ApiErrorModel(this.statusCode,this.errorMessage,{this.unexpectedError = false});

}