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
  const OutletPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DashboardController controller =
    Get.put(DashboardController());
    return Scaffold(
      backgroundColor: const Color(0xffC7F5F5),
      appBar: AppBar(
        backgroundColor: const Color(0xffC7F5F5),
        title: Text(
          "Retail Partner Assessment Survey",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16.h,
          ),
        ),
      ),
      drawer: CustomDrawer(),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20.h),
              CustomInputField(
                icon: Icons.person,
                hintText: 'Enter Respondent\'s name',
              ),
              SizedBox(height: 12.h),
              CustomDropdownField(
                  icon: Icons.real_estate_agent_outlined,
                  hintText: "Respondent's relationship with retail",
                  items: ["owner","employee","other"],
                  controller: controller,
                  fieldName: "relation"
              ),
              SizedBox(height: 12.h),
              CustomInputField(
                icon: Icons.shop,
                hintText: 'Retail name',
              ),
              SizedBox(height: 12.h),
              CustomInputField(
                icon: Icons.edit_road,
                hintText: 'Street',
              ),
              SizedBox(height: 12.h),
              CustomInputField(
                icon: Icons.auto_graph,
                hintText: 'Cluster',
              ),
              SizedBox(height: 12.h),
              CustomInputField(
                icon: Icons.area_chart,
                hintText: 'Area',
              ),
              SizedBox(height: 12.h),
              CustomDropdownField(
                  icon: Icons.real_estate_agent_outlined,
                  hintText: "Partnership or single owner",
                  items: ["Single owner","Partnership"],
                  controller: controller,
                  fieldName: "ownership"
              ),
              SizedBox(height: 12.h),
              CustomInputField(
                icon: Icons.manage_accounts_rounded,
                hintText: 'Owner\'s name',
              ),
              SizedBox(height: 12.h),
              CustomInputField(
                icon: Icons.phone,
                hintText: 'Owner\'s contact number 1',
              ),
              SizedBox(height: 12.h),
              CustomInputField(
                icon: Icons.phone_paused_outlined,
                hintText: 'Owner\'s contact number 2',
              ),
              SizedBox(height: 12.h),
              CustomInputField(
                icon: Icons.business,
                hintText: 'Owner\'s bkash account number',
              ),
              SizedBox(height: 12.h),
              CustomInputField(
                icon: Icons.contact_emergency,
                hintText: 'Point of contact\'s name',
              ),
              SizedBox(height: 12.h),
              CustomInputField(
                icon: Icons.contact_phone,
                hintText: 'Point of contact\'s phone number',
              ),
              SizedBox(height: 12.h),
              CustomDropdownField(
                  icon: Icons.question_mark,
                  hintText: "Who\'s bkash number shall be used to transfer incentives",
                  items: ["Owner’sr","Point of contact"],
                  controller: controller,
                  fieldName: "ownership"
              ),
              SizedBox(height: 12.h),
              CustomDropdownField(
                  icon: Icons.question_mark,
                  hintText: "Trade license's availability",
                  items: ["Yes","No"],
                  controller: controller,
                  fieldName: "trade"
              ),
              SizedBox(height: 12.h),
              CustomInputField(
                icon: Icons.align_vertical_bottom_outlined,
                hintText: 'Average consumer footfall/day',
              ),
              SizedBox(height: 12.h),
              MultiSelectDropdownField(
                  icon: Icons.holiday_village_outlined,
                  hintText: "Weekly off days",
                  items: ["Saturday", "Sunday","Monday", "Tuesday", "Wednesday", "Thursday", "Friday"],
                  controller: controller,
                  fieldName: "holidays"
              ),
              SizedBox(height: 12.h),
              CustomInputField(
                icon: Icons.access_time,
                hintText: 'Open time',
              ),
              SizedBox(height: 12.h),
              CustomInputField(
                icon: Icons.access_time_filled_rounded,
                hintText: 'Close time',
              ),
              SizedBox(height: 12.h),
              TopBrandsInputField(),
              SizedBox(height: 12.h),
              CustomDropdownField(
                  icon: Icons.router,
                  hintText: "Internet hardware availability on premise",
                  items: ["Yes","No"],
                  controller: controller,
                  fieldName: "internet_availability"
              ),
              SizedBox(height: 12.h),
              CustomDropdownField(
                  icon: Icons.camera_enhance,
                  hintText: "CCTV availability on premise",
                  items: ["Yes","No"],
                  controller: controller,
                  fieldName: "cctv_availability"
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
                  fieldName: "Camera_placement"
              ),
              SizedBox(height: 12.h),
              CustomDropdownField(
                  icon: Icons.question_answer,
                  hintText: "Is it going to be placed at any corner?",
                  items: ["yes","no"],
                  controller: controller,
                  fieldName: "cctv_placement",
              ),
              SizedBox(height: 12.h),
              CustomDropdownField(
                icon: Icons.question_answer,
                hintText: "Will the display be placed at eye level?",
                items: ["yes","no"],
                controller: controller,
                fieldName: "cctv_eye_level",
              ),
              SizedBox(height: 12.h),
              CustomDropdownField(
                icon: Icons.question_answer,
                hintText: "Is the retailer happy with the incentive amount offered?",
                items: ["yes","no"],
                controller: controller,
                fieldName: "intersive_happiness",
              ),
              SizedBox(height: 12.h),
              CustomInputField(
                icon: Icons.question_answer,
                hintText: 'If not, what amount does he demand?',
              ),
              SizedBox(height: 12.h),
              CustomInputField(
                icon: Icons.question_answer,
                hintText: 'What is the largest amount of incentive he gets from promotional installation?',
              ),
              SizedBox(height: 12.h),
              CustomInputField(
                icon: Icons.manage_accounts_rounded,
                hintText: 'Who is the client?',
              ),
              SizedBox(height: 12.h),
              CustomInputField(
                icon: Icons.point_of_sale,
                hintText: 'Average daily sales',
              ),
              SizedBox(height: 12.h),
              CustomDropdownField(
                icon: Icons.category,
                hintText: "Retail category",
                items: ["A","B","C"],
                controller: controller,
                fieldName: "retail_category",
              ),
              SizedBox(height: 12.h),
              CustomDropdownField(
                icon: Icons.local_grocery_store,
                hintText: "Retail category",
                items: ["Grocery Shop","Departmental Store","other"],
                controller: controller,
                fieldName: "Retail type",
              ),
              SizedBox(height: 12.h),
              CustomDropdownField(
                icon: Icons.workspace_premium_sharp,
                hintText: "Premises",
                items: ["Wet Market","Market 3","Standalone"],
                controller: controller,
                fieldName: "Premises",
              ),
              SizedBox(height: 10.h),
              ImageSelector(
                icon: Icons.photo,
                hintText: 'Select outlet interior image',
                cameraType: 'interior',
                controller: controller,
              ),
              //SizedBox(height: 10.h),
              ImageSelector(
                icon: Icons.photo,
                hintText: 'Select outlet exterior image',
                cameraType: 'exterior',
                controller: controller,
              ),
              //SizedBox(height: 10.h),
              ImageSelector(
                icon: Icons.photo,
                hintText: 'Select outlet front image',
                cameraType: 'front',
                controller: controller,
              ),
              SizedBox(height: 12.h),
              ImageSelector(
                icon: Icons.photo,
                hintText: 'Select outlet back image',
                cameraType: 'back',
                controller: controller,
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
                    print(controller.interiorBase64Image.value);
                    print(controller.exteriorBase64Image.value);
                    print(controller.frontBase64Image.value);
                    print(controller.backBase64Image.value);
                    // Add your onPressed callback here
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => QuestionairePage()),
                    // );
                  },
                ),
              ),
              SizedBox(height: 30.h),
            ],
          ),
        ),
      ),
    );
  }
}
