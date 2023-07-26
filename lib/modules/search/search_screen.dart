import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/shared/components/components.dart';
import 'package:news_app/shared/cubit/cubit.dart';
import 'package:news_app/shared/cubit/states.dart';

class NewsSearchScreen extends StatelessWidget {
  const NewsSearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var  controller= TextEditingController();
    return BlocConsumer<NewsCubit,NewsAppStates>(
      listener: (context ,state){},
      builder: (context ,state)
      {
        var list  = NewsCubit.get(context).search;
        return Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(20.0),
                color: Colors.grey[350],
                child: defaultTextFormField(
                  controller: controller,
                  keyboardType: TextInputType.text,
                  labelText: 'Search',
                  prefixIcon: Icons.search,
                  validatorString: 'search must not be empty',
                  onchange: (value)
                  {
                    NewsCubit.get(context).getSearchData(value);
                  },
                ),
              ),
              Expanded(child: buildFinalArticleItem(list,context,isSearch: true)),
            ],
          ),
        );
      },
    );
  }
}
