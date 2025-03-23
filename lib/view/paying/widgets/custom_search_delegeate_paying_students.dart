import 'package:drosak_mangment_app/core/resources/colors_manger.dart';
import 'package:drosak_mangment_app/core/resources/const_values.dart';
import 'package:drosak_mangment_app/core/resources/fonts_manger.dart';
import 'package:drosak_mangment_app/view/paying/widgets/custom_list_view_item_paying_students.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/resources/provider/students_provider.dart';

class CustomSearchDelegatedPayingStudent extends SearchDelegate<String> {
  @override
  ThemeData appBarTheme(BuildContext context) {

    // TODO: implement appBarTheme
    return super
        .appBarTheme(context)
        .copyWith(appBarTheme: const AppBarTheme(color: ColorsManger.kPrimaryColor));

  }
  final int groupID; // متغير groupID

  CustomSearchDelegatedPayingStudent({required this.groupID});


  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = "";
        },
        icon: const Icon(Icons.close),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: (){
        close(context, "");



      },
      icon: const Icon(Icons.arrow_back_ios),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return _buildSearchResults(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return _buildSearchResults(context);
  }

  Widget _buildSearchResults(BuildContext context) {
    var provider = Provider.of<StudentsProvider>(context, listen: false);
    provider.getAllSearchPayingItemList(searchWord: query, groupID: groupID,);



    return Directionality(
      textDirection: TextDirection.rtl,
      child: query.isEmpty
          ? const Center(
              child: Text(
                ConstValue.kContentSearch,
                style: TextStyle(
                  fontFamily: FontsName.geDinerFont,
                  color: ColorsManger.kWhiteColor,
                ),
              ),
            )
          : Consumer<StudentsProvider>(
              builder: (context, provider, child) {



                return  CustomListViewItemPayingStudents(listItemStudentModelSelectedByGroup: provider.listSearchPayingItemStudentModel, isSearch: true,

                );
              },
            ),
    );
  }
}
