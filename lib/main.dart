import 'package:flutter/material.dart';
import 'package:flutter_application_2/pages/add_person/logic/bloc/add_user_bloc.dart';
import 'package:flutter_application_2/pages/edit_person/logic/bloc/edit_user_bloc.dart';
import 'package:flutter_application_2/pages/home/home_page.dart';
import 'package:flutter_application_2/pages/home/logic/bloc/home_bloc.dart';
import 'package:flutter_application_2/pages/home/model/home_model.dart';
import 'package:flutter_application_2/theme/theme.dart';
import 'package:flutter_application_2/tools/router/app_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  Hive.registerAdapter(PersonModelAdapter());

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => HomeBloc(),
        ),
        BlocProvider(
          create: (context) => AddUserBloc(),
        ),
        BlocProvider(
          create: (context) => EditUserBloc(),
        ),
      ],
      child: NurseApp(
        appRouter: AppRouter(),
      ),
    ),
  );
}

class NurseApp extends StatelessWidget {
  const NurseApp({super.key, required this.appRouter});

  final AppRouter appRouter;
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => MaterialApp(
        title: "Nurseino",
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('fa'), // English
        ],
        debugShowCheckedModeBanner: false,
        theme: CustomTheme.lightTheme,
        home: const Directionality(
            textDirection: TextDirection.rtl, child: HomePage()),
        onGenerateRoute: appRouter.onGenerateRout,
        initialRoute: HomePage.screenId,
      ),
    );
  }
}
