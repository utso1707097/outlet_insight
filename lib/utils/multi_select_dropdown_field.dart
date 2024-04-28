import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';

import '../controllers/dashboard_controller.dart';

class MultiSelectDropdownField extends StatelessWidget {
  final IconData icon;
  final String hintText;
  final List<String> items;
  final DashboardController controller;
  final RxList<String> fieldVar;

  MultiSelectDropdownField({
    required this.icon,
    required this.hintText,
    required this.items,
    required this.controller,
    required this.fieldVar,
    Key? key,
  }) : super(key: key);
  final MultiSelectController multiSelectController = MultiSelectController();

  @override
  Widget build(BuildContext context) {
    List<ValueItem<String>> valueItems =
        items.map((item) => ValueItem(label: item, value: item)).toList();
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(0),
          height: 40.h,
          width: 40.h,
          decoration: BoxDecoration(
            color: const Color(0xff008DDF),
            borderRadius: BorderRadius.circular(40.h),
          ),
          child: Icon(icon, size: 24.h, color: Colors.white),
        ),
        SizedBox(width: 10.w),
        Container(
          width: 259.w,
          height: 55.h,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(40.w),
          ),
          child: MultiSelectDropDown(
            controller: multiSelectController,
            inputDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40.w),
            ),
            // clearIcon: const Icon(Icons.reddit),
            onOptionSelected: (options) {
              fieldVar.clear();
              fieldVar.refresh();
              for (var element in options) {
                fieldVar.add(element.value);
              }
              fieldVar.refresh();
            },

            options: valueItems,
            hint: hintText,
            hintColor: const Color(0xff7E7B7B),
            hintFontSize: 12.sp,
            // maxItems: 2,
            // disabledOptions: const [ValueItem(label: 'Option 1', value: items[0])],
            selectionType: SelectionType.multi,
            chipConfig: const ChipConfig(wrapType: WrapType.scroll),
            dropdownHeight: 300.h,
            optionTextStyle: TextStyle(fontSize: 12.sp),
            selectedOptionIcon: const Icon(Icons.check_circle),
            focusedBorderColor: Colors.white,
            borderColor: Colors.white,
          ),
        ),
      ],
    );
  }
}
