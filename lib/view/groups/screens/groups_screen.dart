import 'package:drosak_mangment_app/core/resources/const_values.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/resources/provider/groups.dart';
import '../../../core/widgets/app_bar/custom_app_bar.dart';
import '../widgets/custom_list_view_item_groubs.dart';

class GroupScreen extends StatefulWidget {
  const GroupScreen({super.key});

  @override
  State<GroupScreen> createState() => _GroupScreenState();
}

class _GroupScreenState extends State<GroupScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<GroupsProvider>(context, listen: false)
          .getAllItemList();
      Provider.of<GroupsProvider>(context, listen: false)
          .getAllItemListOfTable();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<GroupsProvider>(context);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: buildAppBar(
            context: context,
            length: provider.listItemGroupModel.length,
            openBottomSheet: () {
              provider.openBottomSheet(context: context,);
            },
            showCustomSearch: ()  {
              provider.showCustomSearch(context: context);

            },
            title: ConstValue.kGroups),
        body: CustomListViewItemGroups(
          onRefresh: () async {
            await provider.getAllItemList();
            await provider.getAllItemListOfTable();
          },
          listItemGroupModel:provider.listItemGroupModel ,
        ),
      ),
    );
  }
}
