import 'package:drosak_mangment_app/core/resources/colors_manger.dart';
import 'package:drosak_mangment_app/core/resources/provider/students_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/resources/const_values.dart';
import '../../../core/resources/fonts_manger.dart';
import '../../../core/resources/provider/educatoin_stages.dart';
import '../../../core/resources/provider/groups.dart';
import '../widgets/custom_list_view_item_paying_students.dart';

class PayingScreen extends StatefulWidget {
  const PayingScreen({super.key});

  @override
  State<PayingScreen> createState() => _PayingScreenState();
}


class _PayingScreenState extends State<PayingScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<StudentsProvider>(context, listen: false);
      final providerEducation = Provider.of<EducationStagesProvider>(context, listen: false);

      provider.clearInputs();
      provider.selectedPayingGroup = null;

      Provider.of<GroupsProvider>(context, listen: false)
          .getAllItemListOfTable();


      providerEducation.getAllItemList();
      provider.getAllItemList();
    });
  }


  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<StudentsProvider>(context);
    final providerEducation = Provider.of<EducationStagesProvider>(context);
    final providerGroup = Provider.of<GroupsProvider>(context);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: ColorsManger.kPrimaryColor,
          automaticallyImplyLeading: false,
          title: Text(
            "${ConstValue.kPaying} (${provider.listItemStudentModelSelectedByGroup.length})",

            // " (${provider.listItemStageModel.length})",

            style: TextStyle(
              fontFamily: FontsName.geDinerFont,
              fontSize: FontsSize.f20,
            ),
          ),

          actions: [
            ( provider.selectedPayingGroup==null)?SizedBox.shrink():IconButton(
              iconSize: 30,
              onPressed: () {

                  provider.showCustomPayingSearch(context: context);


              },
              icon: const Icon(Icons.search),
            ),
          ],
        ),
        body:  CustomListViewItemPayingStudents(listItemStudentModelSelectedByGroup: provider.listItemStudentModelSelectedByGroup, isSearch: false, ),
      ),
    );
  }
}
