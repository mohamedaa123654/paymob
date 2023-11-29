import 'package:flutter/cupertino.dart';
import '../../../../core/util/widgets/home_scaffold.dart';
import '../widgets/pay_widget.dart';

class PayPage extends StatelessWidget {
  const PayPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const HomeScaffold(
      widget: PayWidget(),
    );
  }
}
