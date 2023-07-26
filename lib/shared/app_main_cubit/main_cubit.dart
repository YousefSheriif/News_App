import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/shared/app_main_cubit/main_states.dart';
import 'package:news_app/shared/network/local/cache_helper.dart';

  class NewsMainCubit  extends Cubit<NewsAppMainStates>
{

  NewsMainCubit():super(AppInitialState());

  static NewsMainCubit get(context) => BlocProvider.of(context);

  bool isDark = false ;
  void changeAppMode({bool? fromShared})
  {
    if (fromShared != null )
    {
      isDark = fromShared;
    }
    else
    {
      isDark= !isDark;

    }
    CacheHelper.putBoolean(key: 'isDark', value: isDark).then((value)
    {
      emit(ChangeAppModeState());

    });
  }

}