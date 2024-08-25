import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/componanet/componant.dart';
import 'package:news_app/cubit/cubit.dart';
import 'package:news_app/cubit/states.dart';

class sportScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<cubit ,NewsState>(
      listener: (context,states){},
      builder: (context,states){
        var list = cubit.get(context).sports;
        return  NewsBuilder(cubit.get(context).sports);
      },

    );
  }
}
