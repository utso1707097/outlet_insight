import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:outlet_insight/utils/custom_drawer.dart';
import 'package:outlet_insight/utils/custom_dropdown_field.dart';
import 'package:outlet_insight/utils/multi_select_dropdown_field.dart';
import 'package:outlet_insight/utils/top_five_input_filed.dart';

import '../controllers/dashboard_controller.dart';
import '../utils/custom_input_filed.dart';
import '../utils/image_selector.dart';

class OutletPage extends StatelessWidget {
  final GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  final DashboardController controller = Get.put(DashboardController());
  @override
  Widget build(BuildContext context) {
    print("rebuilding");
    return Scaffold(
      backgroundColor: const Color(0xffC7F5F5),
      appBar: AppBar(
        backgroundColor: const Color(0xffC7F5F5),
        title: Text(
          "Retail Partner Assessment Survey",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16.sp,
          ),
        ),
      ),
      drawer: CustomDrawer(),
      body: GestureDetector(
        onTap: () {
          // Unfocus the text field when tapping outside
          FocusScope.of(context).unfocus();
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            child: Form(
              key: globalFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 20.h),
                  CustomInputField(
                    icon: Icons.person,
                    hintText: 'Enter Respondent\'s name',
                    fieldVar: controller.respondent,
                    inputType: TextInputType.text,
                  ),
                  SizedBox(height: 12.h),
                  CustomDropdownField(
                      icon: Icons.real_estate_agent_outlined,
                      hintText: "Respondent's relationship with retail",
                      items: ["owner","employee","other"],
                      controller: controller,
                      fieldVar: controller.relationshipWithRetail,
                  ),
                  SizedBox(height: 12.h),
                  CustomInputField(
                    icon: Icons.shop,
                    hintText: 'Retail name',
                    fieldVar: controller.retailName,
                    inputType: TextInputType.text,
                  ),
                  SizedBox(height: 12.h),
                  CustomInputField(
                    icon: Icons.edit_road,
                    hintText: 'Street',
                    fieldVar: controller.street,
                    inputType: TextInputType.streetAddress,
                  ),
                  SizedBox(height: 12.h),
                  CustomInputField(
                    icon: Icons.auto_graph,
                    hintText: 'Cluster',
                    fieldVar: controller.cluster,
                    inputType: TextInputType.streetAddress,
                  ),
                  SizedBox(height: 12.h),
                  CustomInputField(
                    icon: Icons.area_chart,
                    hintText: 'Area',
                    fieldVar: controller.area,
                    inputType: TextInputType.streetAddress,
                  ),
                  SizedBox(height: 12.h),
                  CustomDropdownField(
                      icon: Icons.real_estate_agent_outlined,
                      hintText: "Partnership or single owner",
                      items: ["Single owner","Partnership"],
                      controller: controller,
                      fieldVar: controller.ownershipType,
                  ),
                  SizedBox(height: 12.h),
                  CustomInputField(
                    icon: Icons.manage_accounts_rounded,
                    hintText: 'Owner\'s name',
                    fieldVar: controller.owner,
                    inputType: TextInputType.text,
                  ),
                  SizedBox(height: 12.h),
                  CustomInputField(
                    icon: Icons.phone,
                    hintText: 'Owner\'s contact number 1',
                    fieldVar: controller.phone1,
                    inputType: TextInputType.phone,
                  ),
                  SizedBox(height: 12.h),
                  CustomInputField(
                    icon: Icons.phone_paused_outlined,
                    hintText: 'Owner\'s contact number 2',
                    fieldVar: controller.phone2,
                    inputType: TextInputType.phone,
                  ),
                  SizedBox(height: 12.h),
                  CustomInputField(
                    icon: Icons.business,
                    hintText: 'Owner\'s bkash account number',
                    fieldVar: controller.bkash,
                    inputType: TextInputType.phone,
                  ),
                  SizedBox(height: 12.h),
                  CustomInputField(
                    icon: Icons.contact_emergency,
                    hintText: 'Point of contact\'s name',
                    fieldVar: controller.pointOfContactName,
                    inputType: TextInputType.text,
                  ),
                  SizedBox(height: 12.h),
                  CustomInputField(
                    icon: Icons.contact_phone,
                    hintText: 'Point of contact\'s phone number',
                    fieldVar: controller.pointOfContactPhone,
                    inputType: TextInputType.phone,
                  ),
                  SizedBox(height: 12.h),
                  CustomDropdownField(
                      icon: Icons.question_mark,
                      hintText: "Who\'s bkash number shall be used to transfer incentives",
                      items: ["Owner’sr","Point of contact"],
                      controller: controller,
                      fieldVar: controller.whoseBkash,
                  ),
                  SizedBox(height: 12.h),
                  CustomDropdownField(
                      icon: Icons.question_mark,
                      hintText: "Trade license's availability",
                      items: ["Yes","No"],
                      controller: controller,
                      fieldVar: controller.tradeAvailability,
                  ),
                  SizedBox(height: 12.h),
                  CustomInputField(
                    icon: Icons.align_vertical_bottom_outlined,
                    hintText: 'Average consumer footfall/day',
                    fieldVar: controller.averageFootfall,
                    inputType: TextInputType.number,
                  ),
                  SizedBox(height: 12.h),
                  MultiSelectDropdownField(
                      icon: Icons.holiday_village_outlined,
                      hintText: "Weekly off days",
                      items: ["Saturday", "Sunday","Monday", "Tuesday", "Wednesday", "Thursday", "Friday"],
                      controller: controller,
                      fieldVar: controller.selectedHolidays,
                  ),
                  SizedBox(height: 12.h),
                  CustomInputField(
                    icon: Icons.access_time,
                    hintText: 'Open time',
                    fieldVar: controller.openTime,
                    inputType: TextInputType.datetime,
                  ),
                  SizedBox(height: 12.h),
                  CustomInputField(
                    icon: Icons.access_time_filled_rounded,
                    hintText: 'Close time',
                    fieldVar: controller.closeTime,
                    inputType: TextInputType.datetime,
                  ),
                  SizedBox(height: 12.h),
                  TopBrandsInputField(controller:controller),
                  SizedBox(height: 12.h),
                  CustomDropdownField(
                      icon: Icons.router,
                      hintText: "Internet hardware availability on premise",
                      items: ["Yes","No"],
                      controller: controller,
                      fieldVar: controller.internetAvailability,
                  ),
                  SizedBox(height: 12.h),
                  CustomDropdownField(
                      icon: Icons.camera_enhance,
                      hintText: "CCTV availability on premise",
                      items: ["Yes","No"],
                      controller: controller,
                      fieldVar: controller.cctvAvailability,
                  ),

                  // If yes, where is the monitor placed
                  SizedBox(height: 12.h),
                  MultiSelectDropdownField(
                      icon: Icons.place_outlined,
                      hintText: "What place is available to mount the display?",
                      items: [
                        "Countertop",
                        "Back wall",
                        "Left side wall",
                        "Right side wall",
                        "Entry column",
                        "Back shelf",
                        "Right shelf",
                        "Left shelf",
                        "Other (Please specify...)"
                      ],
                      controller: controller,
                      fieldVar: controller.selectedCameraPlacementOptions,
                  ),
                  SizedBox(height: 12.h),
                  CustomDropdownField(
                      icon: Icons.question_answer,
                      hintText: "Is it going to be placed at any corner?",
                      items: ["yes","no"],
                      controller: controller,
                      fieldVar: controller.cctvPlacement,
                  ),
                  SizedBox(height: 12.h),
                  CustomDropdownField(
                    icon: Icons.question_answer,
                    hintText: "Will the display be placed at eye level?",
                    items: ["yes","no"],
                    controller: controller,
                    fieldVar: controller.cctvEyeLevel,
                  ),
                  SizedBox(height: 12.h),
                  CustomDropdownField(
                    icon: Icons.question_answer,
                    hintText: "Is the retailer happy with the incentive amount offered?",
                    items: ["yes","no"],
                    controller: controller,
                    fieldVar: controller.incentive_happiness,
                  ),
                  SizedBox(height: 12.h),
                  CustomInputField(
                    icon: Icons.question_answer,
                    hintText: 'If not, what amount does he demand?',
                    fieldVar: controller.amountDemand,
                    inputType: TextInputType.number,
                  ),
                  SizedBox(height: 12.h),
                  CustomInputField(
                    icon: Icons.question_answer,
                    hintText: 'What is the largest amount of incentive he gets from promotional installation?',
                    fieldVar: controller.largestIncentive,
                    inputType: TextInputType.number,
                  ),
                  SizedBox(height: 12.h),
                  CustomInputField(
                    icon: Icons.manage_accounts_rounded,
                    hintText: 'Who is the client?',
                    fieldVar: controller.client,
                    inputType: TextInputType.text,
                  ),
                  SizedBox(height: 12.h),
                  CustomInputField(
                    icon: Icons.point_of_sale,
                    hintText: 'Average daily sales',
                    fieldVar: controller.averageDailySales,
                    inputType: TextInputType.number,
                  ),
                  SizedBox(height: 12.h),
                  CustomDropdownField(
                    icon: Icons.category,
                    hintText: "Retail category",
                    items: ["A","B","C"],
                    controller: controller,
                    fieldVar: controller.retailCategory,
                  ),
                  SizedBox(height: 12.h),
                  CustomDropdownField(
                    icon: Icons.local_grocery_store,
                    hintText: "Retail category",
                    items: ["Grocery Shop","Departmental Store","other"],
                    controller: controller,
                    fieldVar: controller.retailType,
                  ),
                  SizedBox(height: 12.h),
                  CustomDropdownField(
                    icon: Icons.workspace_premium_sharp,
                    hintText: "Premises",
                    items: ["Wet Market","Market 3","Standalone"],
                    controller: controller,
                    fieldVar: controller.premises,
                  ),
                  SizedBox(height: 10.h),
                  ImageSelector(
                    icon: Icons.photo,
                    hintText: 'Select outlet interior image',
                    fieldVar: controller.interiorBase64Image,
                  ),
                  //SizedBox(height: 10.h),
                  ImageSelector(
                    icon: Icons.photo,
                    hintText: 'Select outlet exterior image',
                    fieldVar: controller.exteriorBase64Image,
                  ),
                  //SizedBox(height: 10.h),
                  ImageSelector(
                    icon: Icons.photo,
                    hintText: 'Select outlet front image',
                    fieldVar: controller.frontBase64Image,
                  ),
                  ImageSelector(
                    icon: Icons.photo,
                    hintText: 'Select outlet back image',
                    fieldVar: controller.backBase64Image,
                  ),
                  SizedBox(height: 10.h),
                  Container(
                    width: 70.h,
                    height: 70.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [Color(0xFF0273FD), Color(0xFF00D0FF)],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                    child: IconButton(
                      icon: Icon(Icons.check, color: Colors.white, size: 40.h),
                      onPressed: () {
                        inputLog(controller);
                      },
                    ),
                  ),
                  SizedBox(height: 30.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void inputLog(DashboardController controller) {
    final List<String> logList = [
      "currentUserId: ${controller.currentUserId.value}",
      "respondent: ${controller.respondent.value}",
      "retailName: ${controller.retailName.value}",
      "street: ${controller.street.value}",
      "cluster: ${controller.cluster.value}",
      "area: ${controller.area.value}",
      "owner: ${controller.owner.value}",
      "phone1: ${controller.phone1.value}",
      "phone2: ${controller.phone2.value}",
      "bkash: ${controller.bkash.value}",
      "pointOfContactName: ${controller.pointOfContactName.value}",
      "pointOfContactPhone: ${controller.pointOfContactPhone.value}",
      "averageFootfall: ${controller.averageFootfall.value}",
      "openTime: ${controller.openTime.value}",
      "closeTime: ${controller.closeTime.value}",
      "amountDemand: ${controller.amountDemand.value}",
      "largestIncentive: ${controller.largestIncentive.value}",
      "client: ${controller.client.value}",
      "averageDailySales: ${controller.averageDailySales.value}",
      "relationshipWithRetail: ${controller.relationshipWithRetail.value}",
      "ownershipType: ${controller.ownershipType.value}",
      "tradeAvailability: ${controller.tradeAvailability.value}",
      "whoseBkash: ${controller.whoseBkash.value}",
      "internetAvailability: ${controller.internetAvailability.value}",
      "cctvAvailability: ${controller.cctvAvailability.value}",
      "cctvEyeLevel: ${controller.cctvEyeLevel.value}",
      "cctvPlacement: ${controller.cctvPlacement.value}",
      "incentive_happiness: ${controller.incentive_happiness.value}",
      "retailCategory: ${controller.retailCategory.value}",
      "retailType: ${controller.retailType.value}",
      "premises: ${controller.premises.value}",
      "brand1: ${controller.brand1.value}",
      "brand2: ${controller.brand2.value}",
      "brand3: ${controller.brand3.value}",
      "brand4: ${controller.brand4.value}",
      "brand5: ${controller.brand5.value}",
      "holidays: ${controller.selectedHolidays.value}",
      "camera_positons_available: ${controller.selectedCameraPlacementOptions.value}",
    ];

    logList.forEach((log) {
      print(log);
    });

  }
}

