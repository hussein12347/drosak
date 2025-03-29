import 'package:drosak_mangment_app/core/resources/colors_manger.dart';
import 'package:drosak_mangment_app/core/resources/const_values.dart';
import 'package:drosak_mangment_app/core/resources/fonts_manger.dart';
import 'package:drosak_mangment_app/core/resources/provider/groups.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'custom_list_view_item_groubs.dart';

class CustomSearchDelegatedGroup extends SearchDelegate<String> {
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
    var provider = Provider.of<GroupsProvider>(context, listen: false);
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
          : Consumer<GroupsProvider>(
              builder: (context, provider, child) {
                return CustomListViewItemGroups(
                  listItemGroupModel: provider.listSearchItemGroupModel,
                  onRefresh: () async {
                    await provider.getAllSearchItemList(searchWord: query);
                  }, isSearch: true,
                );
              },
            ),
    );
  }
}
