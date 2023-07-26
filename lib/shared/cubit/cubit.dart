import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/modules/business/business_screen.dart';
import 'package:news_app/modules/science/science_screen.dart';
import 'package:news_app/modules/settings/science_screen.dart';
import 'package:news_app/modules/sports/sports_screen.dart';
import 'package:news_app/shared/cubit/states.dart';
import 'package:news_app/shared/network/remote/dio_helper.dart';

  class NewsCubit  extends Cubit<NewsAppStates>
{

  NewsCubit():super(AppInitialState());

  int currentIndex = 0;
  bool  isBottomSheetShown  = false;

  List<BottomNavigationBarItem>bottomItems =
  [
    const BottomNavigationBarItem(
      icon: Icon(Icons.business,),
      label: 'Business',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.sports,),
      label: 'Sports',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.science,),
      label: 'Science',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.settings,),
      label: 'Settings',
    ),
  ];

  List<String>imgs=
  [
    'https://img.youm7.com/large/202304191211391139.jpg',
    'https://www.elaosboa.com/wp-content/uploads/2023/03/elaosboa71802.jpeg',
    'https://ichef.bbci.co.uk/news/800/cpsprodpb/16267/production/_129572709_ouarzazatesolarplant.jpg',
    'https://i-invdn-com.investing.com/news/LYNXNPEB8F145_L.jpg',
    'https://i-invdn-com.investing.com/news/moved_small-LYNXNPEI48074_L.jpg',
    'https://img.youm7.com/large/202304191211391139.jpg',
    'https://www.elaosboa.com/wp-content/uploads/2023/03/elaosboa71802.jpeg',
    'https://ichef.bbci.co.uk/news/800/cpsprodpb/16267/production/_129572709_ouarzazatesolarplant.jpg',
    'https://i-invdn-com.investing.com/news/LYNXNPEB8F145_L.jpg',
    'https://i-invdn-com.investing.com/news/moved_small-LYNXNPEI48074_L.jpg',
    'https://img.youm7.com/large/202304191211391139.jpg',
    'https://www.elaosboa.com/wp-content/uploads/2023/03/elaosboa71802.jpeg',
    'https://ichef.bbci.co.uk/news/800/cpsprodpb/16267/production/_129572709_ouarzazatesolarplant.jpg',
    'https://i-invdn-com.investing.com/news/LYNXNPEB8F145_L.jpg',
    'https://i-invdn-com.investing.com/news/moved_small-LYNXNPEI48074_L.jpg',
    'https://img.youm7.com/large/202304191211391139.jpg',
    'https://www.elaosboa.com/wp-content/uploads/2023/03/elaosboa71802.jpeg',
    'https://ichef.bbci.co.uk/news/800/cpsprodpb/16267/production/_129572709_ouarzazatesolarplant.jpg',
    'https://i-invdn-com.investing.com/news/LYNXNPEB8F145_L.jpg',
    'https://i-invdn-com.investing.com/news/moved_small-LYNXNPEI48074_L.jpg',
    'https://i-invdn-com.investing.com/news/moved_small-LYNXNPEI48074_L.jpg',
  ];

  List<String> title = [
    'Business News',
    'Science News',
    'Sports News',
    'Settings Options',
  ];
  List<dynamic>business = [];
  List<dynamic>science = [];
  List<dynamic>sports = [];
  List<dynamic>search = [];
List<Widget>screens=
[
  const BusinessScreen(),
  const SportsScreen(),
  const ScienceScreen(),
  const SettingsScreen()
];

  static NewsCubit get(context) => BlocProvider.of(context);


  void changeIndex(index)
  {
    currentIndex= index ;
    if (index ==1) {
      getSportsData();
    }
    if (index ==2) {
      getScienceData();
    }
    emit(AppChangeBottomNavBarState());
  }
  //  https://newsapi.org/v2/top-headlines?country=eg&category=business&apiKey=8d5fe8dce4d14806b0cbd12cad801c2c
  void getBusinessData()
  {
    emit(NewsGetBusinessLoadingState());
    DioHelper.getData(
      url: 'v2/top-headlines',
      query: {
        'country':'eg',
        'category':'business',
        'apiKey':'42824c40383f443ba1fa95fa3672afda',
      },
    //  42824c40383f443ba1fa95fa3672afda
    ).then((value)
    {
      emit(NewsGetBusinessSuccessState());
      // print(value!.data.toString());
      business = value.data['articles'];
      // print(business);
    }).catchError((error)
    {
      emit(NewsGetBusinessErrorState(error.toString()));
      print(error.toString());
    });
  }


  void getScienceData()
  {
    emit(NewsGetScienceLoadingState());
    if(science.length == 0)
      {
        DioHelper.getData(
          url: 'v2/top-headlines',
          query: {
            'country':'eg',
            'category':'science',
            'apiKey':'42824c40383f443ba1fa95fa3672afda',
          },
          //  42824c40383f443ba1fa95fa3672afda
        ).then((value)
        {
          emit(NewsGetScienceSuccessState());
          // print(value!.data.toString());
          science = value.data['articles'];
          // print(business);
        }).catchError((error)
        {
          emit(NewsGetScienceErrorState(error.toString()));
          print(error.toString());
        });
      }
    else
      {
        emit(NewsGetScienceSuccessState());
      }

  }


  void getSportsData()
  {
    emit(NewsGetSportsLoadingState());
    if(sports.length ==0)
      {
        DioHelper.getData(
          url: 'v2/top-headlines',
          query: {
            'country':'eg',
            'category':'sports',
            'apiKey':'42824c40383f443ba1fa95fa3672afda',
          },
        ).then((value)
        {
          emit(NewsGetSportsSuccessState());
          sports = value.data['articles'];
          // print(business);
        }).catchError((error)
        {
          emit(NewsGetSportsErrorState(error.toString()));
          print(error.toString());
        });
      }
    else
      {
        emit(NewsGetSportsSuccessState());
      }
  }

//https://newsapi.org/v2/everything?q=tesla&from=2023-04-06&sortBy=publishedAt&apiKey=42824c40383f443ba1fa95fa3672afda
  void getSearchData( String val)
  {
    emit(NewsGetSearchLoadingState());
    DioHelper.getData(
      url: 'v2/everything',
      query:
      {
        'q':'${val}',
        'apiKey':'42824c40383f443ba1fa95fa3672afda',
      },
    ).then((value)
    {
      emit(NewsGetSearchSuccessState());
      // print(value!.data.toString());
      search = value.data['articles'];
      // print(business);
    }).catchError((error)
    {
      emit(NewsGetSearchErrorState(error.toString()));
      print(error.toString());
    });
  }




  bool isDark = false ;
  void changeAppMode()
  {
    isDark= !isDark;
    emit(ChangeAppModeState());
  }




}