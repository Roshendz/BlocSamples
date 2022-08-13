import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sizer/sizer.dart';

import 'core/constants/strings.dart';
import 'core/themes/app_theme.dart';
import 'logic/cubit/counter_cubit.dart';
import 'logic/cubit/theme_cubit.dart';
import 'logic/debug/app_bloc_observer.dart';
import 'presentation/router/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = AppBlocObserver();
  final storage = await HydratedStorage.build(
    storageDirectory: await getApplicationDocumentsDirectory(),
  );

  HydratedBlocOverrides.runZoned(
    () => runApp(
      DevicePreview(
        enabled: false,
        builder: (context) => App(),
      ),
    ),
    storage: storage,
  );
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ThemeCubit>(
          create: (context) => ThemeCubit(),
        ),
        BlocProvider<CounterCubit>(
          create: (context) => CounterCubit(),
        ),
      ],
      child: const CounterApp(),
    );
  }
}

class CounterApp extends StatefulWidget {
  const CounterApp({
    Key? key,
  }) : super(key: key);

  @override
  _CounterAppState createState() => _CounterAppState();
}

class _CounterAppState extends State<CounterApp> with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void didChangePlatformBrightness() {
    context.read<ThemeCubit>().updateAppTheme();
    super.didChangePlatformBrightness();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return OrientationBuilder(
          builder: (context, orientation) {
            return Sizer(builder: (context, constraints, orientation) {
              return MaterialApp(
                builder: DevicePreview.appBuilder,
                title: Strings.appTitle,
                theme: AppTheme.lightTheme,
                darkTheme: AppTheme.darkTheme,
                themeMode: context.select(
                    (ThemeCubit themeCubit) => themeCubit.state.themeMode),
                debugShowCheckedModeBanner: false,
                initialRoute: AppRouter.counter,
                onGenerateRoute: AppRouter.onGenerateRoute,
              );
            });
          },
        );
      },
    );
  }
}
