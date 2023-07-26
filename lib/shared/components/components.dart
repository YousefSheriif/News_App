import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:news_app/modules/web_view/web_view_screen.dart';

Widget defaultButton({
  Color? color = Colors.blue ,
  double height = 45.0,
  double width = 250.0,
  double radius = 30.0,
  bool isUpper = false,
  required String text,
  required Function,
  Color? textColor = Colors.white ,
  double textSize = 22.0 ,
})
{
  return Center(
    child: Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: color,
      ),
      child: MaterialButton(
        onPressed: Function,
        child: Text(
          isUpper?text.toUpperCase():text,
          style: TextStyle(
            color: textColor,
            fontSize: textSize,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ),
  );

}




Widget defaultTextFormField({
  required TextEditingController? controller,
  required TextInputType keyboardType ,
  required String ? labelText ,
  required IconData ?prefixIcon,
  void Function(String val)? onSubmit,
  void Function(String value)? onchange,
  void Function()? onTab,
  void Function()? suffixOnPressed,
  required String ? validatorString ,
  IconData ?suffixIcon,
  bool isPassword  = false ,
  Color? color = Colors.grey ,
})
{
  return TextFormField(
    controller: controller,
    keyboardType:keyboardType ,
    onChanged: onchange,
    onFieldSubmitted: onSubmit,
    onTap: onTab,
    validator: (val)
    {
      if (val!.isEmpty)
      {
        return validatorString;
      }
      return null;
    },
    obscureText: isPassword ,
    decoration: InputDecoration(
      prefixIcon: Icon(prefixIcon,),
      prefixIconConstraints:BoxConstraints(minWidth: 50.0 ),
      suffixIcon:
      IconButton(
        icon: Icon(suffixIcon,color:color,),
        onPressed: suffixOnPressed,
      ),
      labelText: labelText,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
    ),
  ) ;
}

Widget buildArticleItem(list,context)//imgs
{
  return InkWell(
    onTap: ()
    {
      navigateTo(context, WebViewScreen(url:list['url']));

    },
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              image: DecorationImage(
                fit: BoxFit.fill,
                image: NetworkImage('https://i-invdn-com.investing.com/news/moved_small-LYNXNPEI48074_L.jpg'),//    ${imgs}     ${list['urlToImage']}
              ),
            ),
          ),
          const SizedBox(width: 15.0,),
          Expanded(
            child:Container(
              height: 120.0,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child:Text(
                      '${list['title']}',
                      style:Theme.of(context).textTheme.bodyText1 ,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    '${list['publishedAt']}',
                    style: TextStyle(
                        color: Colors.grey
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget buildFinalArticleItem(list,context,{bool isSearch = false})
{
  return ConditionalBuilder(
    condition: list.length >0,
    builder: (context)=> ListView.separated(
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) => buildArticleItem(list[index],context),//,imgss[index]
      separatorBuilder: (context, index) => Padding(
        padding: const EdgeInsetsDirectional.only(start: 10.0),
        child: Container(
          width: double.infinity,
          height: 1.0,
          color: Colors.grey[300],
        ),
      ),
      itemCount: list.length,
    ),
    fallback: (context) => isSearch ?Container(): const Center(child: CircularProgressIndicator()),
  ) ;
}


void navigateTo(context ,Widget)
{
    Navigator.push(context, MaterialPageRoute(
    builder: (context)
    {
      return Widget;
    },
      ),
    );
}