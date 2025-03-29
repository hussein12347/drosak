import 'package:drosak_mangment_app/core/resources/colors_manger.dart';
import 'package:drosak_mangment_app/core/resources/const_values.dart';
import 'package:drosak_mangment_app/core/resources/fonts_manger.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/resources/provider/educatoin_stages.dart';
import 'custom_list_view_item_stages.dart';

class CustomSearchDelegated extends SearchDelegate<String> {
  @override
  ThemeData appBarTheme(BuildContext context) {
    // TODO: implement appBarTheme
    return super
        .appBarTheme(context)
        .copyWith(appBarTheme: const AppBarTheme(color: ColorsManger.kPrimaryColor));
  }

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
      onPressed: () => close(context, ""),
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
    var provider = Provider.of<EducationStagesProvider>(context, listen: false);
    provider.getAllSearchItemList(searchWord: query);

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
          : Consumer<EducationStagesProvider>(
              builder: (context, provider, child) {
                return CustomListViewItemStages(
                  itemStageModel: provider.listSearchItemStageModel,
                  onRefresh: () async {
                    await provider.getAllSearchItemList(searchWord: query);
                  }, isSearch: true,
                );
              },
            ),
    );
  }
}
