import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/resources/const_values.dart';
import '../../../core/resources/provider/students_provider.dart';
import '../../../core/widgets/app_bar/custom_app_bar.dart';
import '../widgets/custom_list_view_item_students.dart';

class StudentsScreen extends StatefulWidget {
  const StudentsScreen({super.key});

  @override
  State<StudentsScreen> createState() => _StudentsScreenState();
}

class _StudentsScreenState extends State<StudentsScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<StudentsProvider>(context, listen: false)
          .getAllItemList();

    });
  }
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<StudentsProvider>(context);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: buildAppBar(
            context: context,
            length: provider.listItemStudentModel.length,
            openBottomSheet: () {
              provider.openBottomSheet(context: context,);
            },
            showCustomSearch: () async {
              provider.showCustomSearch(context: context);
            },
            title: ConstValue.kStudents),
        body: CustomListViewItemStudents(
          onRefresh: () async {
            await provider.getAllItemList();
            // await provider.getAllItemListOfTable();
          }, listItemStudentModel: provider.listItemStudentModel,
        ),
      ),
    );
  }
}
