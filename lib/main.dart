import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'home/ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'home/cubit.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => PriceCubit(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              fontFamily: 'Irs',
              colorScheme: const ColorScheme(
                  brightness: Brightness.dark,
                  primary: Color.fromRGBO(252, 163, 17, 1),
                  onPrimary: Color.fromRGBO(255, 255, 255, 1),
                  secondary: Color.fromRGBO(0, 0, 0, 1),
                  onSecondary: Color.fromRGBO(229, 229, 229, 1),
                  error: Colors.redAccent,
                  onError: Colors.black,
                  surface: Color.fromRGBO(20, 33, 61, 1),
                  onSurface: Colors.white)),
          home: Builder(builder: (context) {
            return const HomePage();
          }),
        ));
  }
}
