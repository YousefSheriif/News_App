import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:news_app/layout/news_home_layout.dart';
import 'package:news_app/shared/app_main_cubit/main_cubit.dart';
import 'package:news_app/shared/app_main_cubit/main_states.dart';
import 'package:news_app/shared/cubit/bloc_observer.dart';
import 'package:news_app/shared/cubit/cubit.dart';
import 'package:news_app/shared/network/local/cache_helper.dart';
import 'package:news_app/shared/network/remote/dio_helper.dart';

void main()async
{
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  bool? dark = CacheHelper.getBoolean(key: 'isDark');
  runApp( MyApp(isDarkk: dark,));
}

class MyApp extends StatelessWidget {
   MyApp({super.key,required this.isDarkk});
   bool? isDarkk ;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => NewsCubit()..getBusinessData(),),
        BlocProvider(create: (context)=> NewsMainCubit()..changeAppMode(fromShared: isDarkk), ),
      ],
      child: BlocConsumer<NewsMainCubit,NewsAppMainStates>(
        listener: (context,state){},
        builder: (context,state)
        {
          return MaterialApp(
            theme: ThemeData(
              textTheme:TextTheme(
                bodyText1: TextStyle(
                  fontSize: 17.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              primarySwatch: Colors.deepOrange,
              scaffoldBackgroundColor: Colors.white,
              appBarTheme: AppBarTheme(
                backwardsCompatibility: false,
                titleSpacing: 20.0,
                systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor: Colors.white,
                    statusBarIconBrightness: Brightness.dark
                ),
                color: Colors.white,
                elevation: 0.0,
                titleTextStyle: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepOrange,
                ),
                iconTheme: IconThemeData(
                    color: Colors.black
                ),
              ),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                type: BottomNavigationBarType.fixed,
                selectedItemColor: Colors.deepOrange,
                unselectedItemColor: Colors.grey,
                backgroundColor: Colors.white,
                elevation: 30.0,
              ),
            ),
            darkTheme: ThemeData(
                textTheme:TextTheme(
                bodyText1: TextStyle(
                  color: Colors.white,
                  fontSize: 17.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
                primarySwatch: Colors.deepOrange,
                scaffoldBackgroundColor: HexColor('333739'),
                appBarTheme: AppBarTheme(
                  titleSpacing: 20.0,
                  backwardsCompatibility: false,
                  systemOverlayStyle: SystemUiOverlayStyle(
                      statusBarColor: HexColor('333739'),
                      statusBarIconBrightness: Brightness.light
                  ),
                  color: HexColor('333739'),
                  elevation: 0.0,
                  titleTextStyle: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepOrange,
                  ),
                  iconTheme: IconThemeData(
                      color: Colors.white
                  ),
                ),
                bottomNavigationBarTheme: BottomNavigationBarThemeData(
                  backgroundColor: HexColor('333739'),
                  unselectedItemColor: Colors.grey,
                  type: BottomNavigationBarType.fixed,
                  elevation: 30.0,
                ),
            ),
            themeMode: NewsMainCubit.get(context).isDark ?ThemeMode.dark:ThemeMode.light,
            debugShowCheckedModeBanner: false,
            home: NewsLayout(),
          );
        },
      ),
    );
  }
}
