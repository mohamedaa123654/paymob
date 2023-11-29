import 'package:meta/meta.dart';

@immutable
abstract class AppState {}

class Empty extends AppState {}

class Loading extends AppState {}

class Loaded extends AppState {}

class Error extends AppState {}

class ThemeLoaded extends AppState {}

class ChangeModeState extends AppState {}

class ChangeLanguageState extends AppState {}

class LanguageLoaded extends AppState {}

class ChangeLoaded extends AppState {}

// class LoadingGetPaymentTokenState extends AppState {}
//
// class SuccessGetPaymentTokenState extends AppState {}
//
// class ErrorGetPaymentTokenState extends AppState {}
//
// class LoadingMakePaymentState extends AppState {}
//
// class SuccessMakePaymentState extends AppState {}
//
// class ErrorMakePaymentState extends AppState {}


class LoadingGetTokenState extends AppState {}

class ErrorGetTokenState extends AppState {}

class SuccessGetTokenState extends AppState {}

class LoadingOrderState extends AppState {}

class ErrorOrderState extends AppState {}

class SuccessOrderState extends AppState {}

class LoadingPaymentState extends AppState {}

class ErrorPaymentState extends AppState {}

class SuccessPaymentState extends AppState {}





