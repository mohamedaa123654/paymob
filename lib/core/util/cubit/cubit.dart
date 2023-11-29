import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:paymob/core/network/remote/api_endpoints.dart';
import 'package:paymob/core/util/cubit/state.dart';
import '../../di/injection.dart';
import '../../models/get_token_model.dart';
import '../../models/make_order_model.dart';
import '../../models/payment_model.dart';
import '../../network/local/cache_helper.dart';
import '../../network/repository.dart';
import '../constants.dart';
import '../translation.dart';

class AppCubit extends Cubit<AppState> {
  final Repository _repository;

  AppCubit({
    required Repository repository,
  })  : _repository = repository,
        super(Empty());

  static AppCubit get(context) => BlocProvider.of(context);

  late TranslationModel translationModel;

  bool isRtl = false;
  bool isRtlChange = false;
  bool isDark = false;
  bool isPassword = true;
  IconData suffix = Icons.visibility_outlined;
  late ThemeData lightTheme;
  late ThemeData darkTheme;
  late String family;

  void setThemes({
    required bool dark,
    required bool rtl,
  }) {
    isRtl = rtl;
    isRtlChange = rtl;
    isDark = dark;

    debugPrint('dark mode now is------------- $isDark');

    changeTheme();

    emit(ThemeLoaded());
  }


  void changeLanguage({required bool value}) async {
    isRtl = !isRtl;

    sl<CacheHelper>().put('isRtl', isRtl);
    String translation = await rootBundle
        .loadString('assets/translations/${isRtl ? 'ar' : 'en'}.json');

    setTranslation(
      translation: translation,
    );

    emit(ChangeLanguageState());
  }

  void changeMode({required bool value}) {
    isDark = value;

    sl<CacheHelper>().put('isDark', isDark);

    emit(ChangeModeState());
  }

  void changeTheme() {
    family = isRtl ? 'Cairo' : 'Poppins';

    lightTheme = ThemeData(
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: AppBarTheme(
        systemOverlayStyle: Platform.isIOS
            ? null
            : const SystemUiOverlayStyle(
                statusBarColor: whiteColor,
                statusBarIconBrightness: Brightness.dark,
              ),
        backgroundColor: whiteColor,
        elevation: 0.0,
        titleSpacing: 0.0,
        iconTheme: const IconThemeData(
          size: 20.0,
          color: Colors.black,
        ),
        titleTextStyle: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontFamily: family,
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: whiteColor,
        elevation: 50.0,
        selectedItemColor: HexColor(mainColor),
        unselectedItemColor: Colors.grey[400],
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: const TextStyle(
          height: 1.5,
        ),
      ),
      primarySwatch: const MaterialColor(955, color),
      textTheme: TextTheme(

        headline6: TextStyle(
          fontSize: pxToDp(20.0),
          fontFamily: family,
          color: HexColor(secondaryVariant),
          height: 1.4,
        ),
        bodyText1: TextStyle(
          fontSize: pxToDp(18.0),
          fontFamily: family,
          color: HexColor(secondaryVariant),
          height: 1.4,
        ),
        bodyText2: TextStyle(
          fontSize: pxToDp(16.0),
          fontFamily: family,
          color: HexColor(secondaryVariant),
          height: 1.4,
        ),
        subtitle1: TextStyle(
          fontSize: pxToDp(14.0),
          fontFamily: family,
          color: HexColor(secondaryVariant),
          height: 1.4,
        ),
        subtitle2: TextStyle(
          fontSize: pxToDp(12.0),
          fontFamily: family,
          color: HexColor(secondaryVariant),
          height: 1.4,
        ),
        caption: TextStyle(
          fontSize: pxToDp(10.0),
          fontFamily: family,
          color: HexColor(secondaryVariant),
          height: 1.4,
        ),
        overline: TextStyle(
          fontSize: pxToDp(8.0),
          fontFamily: family,
          color: HexColor(secondaryVariant),
          height: 1.4,
        ),
        button: TextStyle(
          fontSize: pxToDp(16.0),
          fontFamily: family,
          fontWeight: FontWeight.w700,
          color: whiteColor,
          height: 1.4,
        ),
      ),
    );

    darkTheme = ThemeData(
      scaffoldBackgroundColor: HexColor(scaffoldBackgroundDark),
      appBarTheme: AppBarTheme(
        systemOverlayStyle: Platform.isIOS
            ? null
            : SystemUiOverlayStyle(
          statusBarColor: HexColor(scaffoldBackgroundDark),
          statusBarIconBrightness: Brightness.light,
        ),
        backgroundColor: HexColor(scaffoldBackgroundDark),
        elevation: 0.0,
        titleSpacing: 0.0,
        iconTheme: IconThemeData(
          size: 20.0,
          color: HexColor(regularGrey),
        ),
        titleTextStyle: TextStyle(
          color: HexColor(regularGrey),
          fontFamily: family,
          fontWeight: FontWeight.bold,
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: HexColor(scaffoldBackgroundDark),
        elevation: 50.0,
        selectedItemColor: HexColor(mainColor),
        unselectedItemColor: HexColor(regularGrey),
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: const TextStyle(
          height: 1.5,
        ),
      ),
      primarySwatch: const MaterialColor(955, color),
      textTheme: TextTheme(
        headline6: TextStyle(
          fontSize: pxToDp(20.0),
          fontFamily: family,
          fontWeight: FontWeight.w700,
          color: HexColor(secondaryDark),
        ),
        bodyText1: TextStyle(
          fontSize: pxToDp(16.0),
          fontFamily: family,
          fontWeight: FontWeight.w400,
          color: HexColor(secondaryVariantDark),
        ),
        bodyText2: TextStyle(
          fontSize: pxToDp(14.0),
          fontFamily: family,
          fontWeight: FontWeight.w700,
          color: HexColor(secondaryVariantDark),
        ),
        subtitle1: TextStyle(
          fontSize: pxToDp(12.0),
          fontFamily: family,
          fontWeight: FontWeight.w700,
          color: HexColor(secondaryVariantDark),
        ),
        subtitle2: TextStyle(
          fontSize: pxToDp(12.0),
          fontFamily: family,
          fontWeight: FontWeight.w400,
          color: HexColor(secondaryVariantDark),
        ),
        caption: TextStyle(
          fontSize: pxToDp(11.0),
          fontFamily: family,
          fontWeight: FontWeight.w400,
          color: HexColor(secondaryDark),
        ),
        button: TextStyle(
          fontSize: pxToDp(16.0),
          fontFamily: family,
          fontWeight: FontWeight.w700,
          color: whiteColor,
        ),
      ),
    );

  }

  void setTranslation({
    required String translation,
  }) {
    translationModel = TranslationModel.fromJson(json.decode(
      translation,
    ));

    emit(LanguageLoaded());
  }


  /// payments


/// checkout
  // String publicKey = 'pk_sbox_tamtzj3whqf7onfnvy6i7vupja2';
  // String privateKey = 'sk_sbox_is3aowbnj5inuejvwakktqscq4i';

  // getPaymentToken(PaymentCardModel card)
  // async{
  //
  //
  //
  // }


  // PaymentTokenModel? paymentTokenModel;
  //
  // void getPaymentToken() async
  // {
  //   emit(LoadingGetPaymentTokenState());
  //   final paymentToken = await _repository.getToken(
  //       publicKey: publicKey,
  //       cardNum: '4242424242424242',
  //       expiryMonth: '12',
  //       expiryYear: '2024',
  //   );
  //
  //   paymentToken.fold(
  //       (failure)
  //       {
  //         emit(ErrorGetPaymentTokenState());
  //         debugPrint(failure.toString());
  //       },
  //       (data)
  //       {
  //         paymentTokenModel = data;
  //         emit(SuccessGetPaymentTokenState());
  //         payment(
  //             token: paymentTokenModel!.token!);
  //       }
  //
  //   );
  //
  // }
  //
  // PaymentModel? paymentModel;
  //
  // void payment({
  //   required String token
  // }) async{
  //   emit(LoadingMakePaymentState());
  //   final payment = await _repository.makePayment(
  //       token: token,
  //       secretKey: privateKey,
  //       amount: 5000,
  //   );
  //
  //   payment.fold(
  //           (failure)
  //       {
  //         emit(ErrorMakePaymentState());
  //         debugPrint(failure.toString());
  //       },
  //           (data)
  //       {
  //         paymentModel = data;
  //         emit(SuccessMakePaymentState());
  //       }
  //
  //   );
  //
  // }


// void makePayment(PaymentCardModel card, int amount)
  // async{
  // String token = await getPaymentToken(card);
  //
  // }

/// paymob

  GetTokenModel? getTokenModel;

  void getToken() async
  {
    emit(LoadingGetTokenState());
    final getToken = await _repository.getToken(
        key: apiKey
    );

    getToken.fold(
        (failure)
        {
          emit(ErrorGetTokenState());
          debugPrintFullText(failure.toString());
        },
        (data)
        {
          getTokenModel = data;
          emit(SuccessGetTokenState());
          makeOrder();
        }
    );

  }

  MakeOrderModel? makeOrderModel;

  void makeOrder() async
  {
    emit(LoadingOrderState());
    final makeOrder = await _repository.makeOrder(
        token: getTokenModel!.token!,
        amount: '10000',
        currency: 'EGP',
        delivery: false,
        items: [],
    );
    makeOrder.fold(
            (failure)
        {
          emit(ErrorOrderState());
          debugPrintFullText(failure.toString());
        },
            (data)
        {
          makeOrderModel = data;
          emit(SuccessOrderState());
          makePayment();
        }
    );

  }

  PaymentModel? paymentModel;

  void makePayment() async
  {
    emit(LoadingPaymentState());
    final payment = await _repository.makePayment(
      token: getTokenModel!.token!,
      amount: '10000',
      currency: 'EGP',
      orderId: '${makeOrderModel!.id}',
      integrationId: integrationId,
    );
    payment.fold(
            (failure)
        {
          emit(ErrorPaymentState());
          debugPrintFullText(failure.toString());
        },
            (data)
        {
          paymentModel = data;
          emit(SuccessPaymentState());
        }
    );

  }



}
