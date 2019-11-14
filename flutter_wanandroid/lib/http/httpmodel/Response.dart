class Response<T> {
  T data;
  int errorCode;
  String errorMsg;

  Response(this.data, this.errorCode, this.errorMsg);
}
