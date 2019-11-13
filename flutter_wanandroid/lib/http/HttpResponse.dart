class HttpResponse<T> {
  T data;
  int errorCode;
  String errorMsg;

  HttpResponse(this.data, this.errorCode, this.errorMsg);
}
