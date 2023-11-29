import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paymob/core/util/constants.dart';
import 'package:paymob/core/util/widgets/my_button.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../../../core/network/remote/api_endpoints.dart';
import '../../../../core/util/cubit/cubit.dart';
import '../../../../core/util/cubit/state.dart';
import '../pages/pay_page.dart';

class HomeWidget extends StatelessWidget {
  const HomeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppState>(
      listener: (context, state)
      {
        if(state is SuccessPaymentState)
        {
         navigateTo(context, const PayPage());
         debugPrint('done');
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: MyButton(
                    onPressed: ()
                    {
                      // AppCubit.get(context).getPaymentToken();
                      AppCubit.get(context).getToken();
                    },
                    text: 'Pay Now'
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
