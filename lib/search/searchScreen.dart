import 'dart:ffi';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/componanet/componant.dart';
import 'package:news_app/cubit/cubit.dart';
import 'package:news_app/cubit/states.dart';

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var list =cubit.get(context).search;
    var searchController =TextEditingController();
    return BlocConsumer<cubit,NewsState>(
      listener: (context,states){},
      builder: (context,states){
        return Scaffold(
          appBar: AppBar(),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                defaultformfield(
                  controller:searchController,
                  keyboardtype: TextInputType.text,
                  onChanged: (value){
                     cubit.get(context).getSearch(value!);
                  },
                  validate: (String?value){
                    if(value!.isEmpty){
                      return "search musn't be empty";
                    }
                    return null;
                  },
                  label:'search',
                  pre_icon: Icons.search,
                ),
                SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: NewsBuilder(cubit.get(context).search,),),
              ],
            ),
          ),

        );
      },
    );
  }
}
