import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:reality_near/core/framework/colors.dart';
import 'package:reality_near/presentation/bloc/menu/menu_bloc.dart';
import 'package:reality_near/presentation/bloc/user/user_bloc.dart';
import 'package:reality_near/presentation/providers/location_provider.dart';
import 'package:reality_near/presentation/views/firstScreen/firstScreen.dart';
import 'package:reality_near/core/routes.dart';
import 'package:reality_near/presentation/views/homeScreen/homeScreen.dart';
import 'package:reality_near/presentation/views/mapScreen/widgets/map.dart';

void main() {
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => UserBloc()),
        BlocProvider(create: (context) => MenuBloc()),
      ],
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => LocationProvider(),
            child: MapSection(),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Reality Near',
          theme: ThemeData(
            primarySwatch: Palette.kgreenNR,
          ),
          initialRoute: HomeScreen.routeName,
          routes: routes,
        ),
      ),
    );
  }
}
