class ViewState<T> {
  T? data;
  int? errorCode;
  String? errorMessage;

  ViewState({this.data, this.errorCode, this.errorMessage});

  bool isLoading() => this is ViewStateLoading;

  bool isError() => this is ViewStateError;

  bool isEmpty() => this is ViewStateEmpty;

  bool isSuccess() => this is ViewStateSuccess;

  bool isFail() => this is ViewStateFail;
}

class ViewStateLoading extends ViewState {}

class ViewStateEmpty extends ViewState {}

class ViewStateError extends ViewState {
  ViewStateError(int? errorCode, String? errorMessage)
      : super(errorCode: errorCode, errorMessage: errorMessage);
}

class ViewStateFail extends ViewState {
  ViewStateFail(int? errorCode, String? errorMessage)
      : super(errorCode: errorCode, errorMessage: errorMessage);
}

class ViewStateSuccess<T> extends ViewState<T> {
  ViewStateSuccess(T data) : super(data: data);
}


