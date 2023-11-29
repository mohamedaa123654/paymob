import 'package:data_connection_checker_nulls/data_connection_checker_nulls.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/di/injection.dart' as di;
import 'core/di/injection.dart';
import 'core/network/local/cache_helper.dart';
import 'core/util/constants.dart';
import 'core/util/cubit/cubit.dart';
import 'core/util/cubit/state.dart';
import 'features/home/presentation/pages/home_page.dart';
import 'features/no connection/presentation/pages/no_connection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();


  await di.init();


  bool isRtl = false;

  await sl<CacheHelper>().get('isRtl').then((value) {
    debugPrint('trl ------------- $value');
    if (value != null) {
      isRtl = value;
    }
  });

  bool isDark = false;


  await sl<CacheHelper>().get('isDark').then((value) {
    debugPrint('dark mode in cubit is------------- $value');
    if (value != null) {
      isDark = value;
    }
  });

  String translation = await rootBundle
      .loadString('assets/translations/${isRtl ? 'ar' : 'en'}.json');

  runApp(MyApp(
    isRtl: isRtl,
    isDark: isDark,
    translation: translation,
    startWidget: const HomePage(),
  ));
}

class MyApp extends StatelessWidget {
  final Widget startWidget;
  final bool isRtl;
  final bool isDark;
  final String translation;

  MyApp({
    Key? key,
    required this.isRtl,
    required this.isDark,
    required this.translation,
    required this.startWidget,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (BuildContext context) => sl<AppCubit>()
              ..setThemes(
                dark: isDark,
                rtl: isRtl,
              )..setTranslation(
                translation: translation,
              )
        ),
      ],
      child: BlocBuilder<AppCubit, AppState>(
        builder: (context, state) {
          DataConnectionChecker().onStatusChange.listen((status)
          {
            if (status == DataConnectionStatus.disconnected) {
              debugPrint('No internet connection');
            } else {
              debugPrint('Internet connection is available');
            }
            isConnection = status;
            debugPrint('data Connection ${isConnection.toString()}');
          });
          return MaterialApp(
            title: 'Payments',
            debugShowCheckedModeBanner: false,
            themeMode: AppCubit.get(context).isDark
                ? ThemeMode.dark
                : ThemeMode.light,
            theme: AppCubit.get(context).lightTheme,
            darkTheme: AppCubit.get(context).darkTheme,
            home: isConnection == DataConnectionStatus.disconnected?
            const NoConnectionPage() : startWidget,
          );
        },
      ),
    );
  }
}
