import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:news_app/cubit/cubit.dart';
import 'package:news_app/web_view/web_view.dart';
Widget ArticleItems (article,context)=> InkWell(
  onTap: (){
    navigateTo(context, WebViewScreen(article['url']));
  },
  child:   Padding(

    padding: const EdgeInsets.all(20.0),

    child: Row

      (

      children: [

        Container(

          height: 120,

          width: 120,

          decoration: BoxDecoration(

            borderRadius: BorderRadius.circular(15),

            image: DecorationImage(

              image: NetworkImage('${article['urlToImage']}'),

              fit: BoxFit.cover,

            ),

          ),

        ),

        SizedBox(

          width: 20,

        ),

        Expanded(

          child: Container(

            height: 120,

            child: Column(

              crossAxisAlignment: CrossAxisAlignment.start,

              mainAxisAlignment: MainAxisAlignment.start,

              children: [

                Expanded(

                  child: Text('${article['title']}',

                    style: Theme.of(context).textTheme.bodyText1,

                    maxLines: 3,

                    overflow: TextOverflow.ellipsis,

                  ),

                ),

                Text('${article['publishedAt']}',

                style: TextStyle(

                  color: Colors.grey,

                ),),
              ],
            ),
          ),
        ),
      ],
    ),
  ),
);
Widget myDividor()=>Padding(
  padding: const EdgeInsetsDirectional.only(start: 20.0),
  child: Container(
    height: 1.0,
    width: double.infinity,
    color: Colors.grey[300],
  ),

);
/*Widget articleBuilder(list,context)=> ConditionalBuilder(
  condition:list.length>0,
  builder:(context)=>
      ListView.separated(
          physics: BouncingScrollPhysics(),
          itemBuilder: (context,index)=>ArticleItems(list[index],context) ,
          separatorBuilder: (context,index)=>myDividor(),
          itemCount: cubit.get(context).screens[index].length),
  fallback:(context)=> Center(
          child: CircularProgressIndicator()),
);*/

Widget BuildArticleItem(Map model,context)
       => InkWell(
  onTap: ()
  {
    navigateTo(context,WebViewScreen(model['url']));
  },
  child:   Padding(

    padding: const EdgeInsets.all(20.0),

    child: Row(

      children: [

        Container(

          width: 120.0,

          height: 120.0,

          decoration: BoxDecoration(

              borderRadius: BorderRadius.circular(10.0),

              image: DecorationImage(

                  image: NetworkImage('${model['urlToImage']}'),

                  fit: BoxFit.cover

              )

          ),

        ),

        SizedBox(width: 30.0,),

        Expanded(

          child: Container(

            height: 120.0,

            child: Column(

              mainAxisAlignment: MainAxisAlignment.start,

              crossAxisAlignment: CrossAxisAlignment.start,

              //mainAxisSize: MainAxisSize.min,

              children:

              [

                Expanded(

                  child: Text(

                    model['title'],

                    maxLines: 3 ,

                    overflow: TextOverflow.ellipsis,

                    style: Theme.of(context).textTheme.bodyText1,

                  ),

                ),

                SizedBox(height: 8.0,),

                Text(

                  model["publishedAt"],

                  style: TextStyle(
                    color: Colors.grey ,
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

Widget NewsView(List<dynamic> Tasks)
{
  return  ListView.separated(
      physics: BouncingScrollPhysics(),
      itemBuilder: (context, index) => BuildArticleItem(Tasks[index],context),
      separatorBuilder: (context, index) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container
          (
          width: double.infinity,
          height: 2.0,
          color: Colors.grey[200],
        ),
      ),
      itemCount: Tasks.length
  );
}

Widget NewsBuilder(List,{bool isSearch=false})
     {
  return  List.isNotEmpty ?
  NewsView(List) :
  isSearch?
  Container():
  Center(child: CircularProgressIndicator(color: Colors.deepOrange,)) ;
}

Widget defaultformfield({
  required TextEditingController controller,
  required TextInputType keyboardtype,
  void Function(String?)? onSubmit,
  void Function(String?)? onChanged,
  required String? Function(String? value) validate,
  required String label,
  required IconData pre_icon,
  IconData? suf_Icon,
  bool isPassword = false,
  VoidCallback? suffixPressed,
  VoidCallback? onTap,
}) =>
    TextFormField(
      obscureText: isPassword,
      controller: controller,
      keyboardType: keyboardtype,
      onFieldSubmitted: onSubmit,
      onChanged: onChanged,
      onTap: onTap,
      validator: validate,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: label,
        prefixIcon: Icon(pre_icon),
        suffixIcon: suf_Icon != null
            ? IconButton(onPressed: suffixPressed, icon: Icon(suf_Icon))
            : null,
      ),
    );
 void navigateTo (context,widget)=>Navigator.push(
   context,
 MaterialPageRoute(builder: (context)=>widget,
 ),
 );