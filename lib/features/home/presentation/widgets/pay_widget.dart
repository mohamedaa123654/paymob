import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paymob/core/util/widgets/my_button.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../../../core/network/remote/api_endpoints.dart';
import '../../../../core/util/cubit/cubit.dart';
import '../../../../core/util/cubit/state.dart';

class PayWidget extends StatelessWidget {
  const PayWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit,AppState>(
      builder: (context, state) {
        return Scaffold(
          body: WebView(
            initialUrl: '$iFrameUrl${AppCubit.get(context).paymentModel!.token}',
          ),
        );
      },
    );
  }
}