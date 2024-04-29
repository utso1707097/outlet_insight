import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/custom_drawer.dart';
import '../utils/custom_text_field.dart';

class ShowOutletPage extends StatelessWidget {
  final Map<String, dynamic> outletData;
  const ShowOutletPage({super.key, required this.outletData});

  @override
  Widget build(BuildContext context) {
    log(outletData.toString());
    return Scaffold(
      backgroundColor: const Color(0xffC7F5F5),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xffC7F5F5),
        title: Text(
          outletData["name"],
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16.sp,
          ),
        ),
      ),
      drawer: const CustomDrawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // CustomTextField(
              //   label: "ID:",
              //   value: outletData['id'] ?? '',
              // ),
              CustomTextField(
                label: "Respondent Name:",
                value: outletData['respondent_name'] ?? '',
              ),
              CustomTextField(
                label: "Respondent Relation with Retail:",
                value: outletData['respondent_relation_with_retail'] ?? '',
              ),
              CustomTextField(
                label: "Outlet Name:",
                value: outletData['name'] ?? '',
              ),
              CustomTextField(
                label: "Address Street:",
                value: outletData['address_street'] ?? '',
              ),
              CustomTextField(
                label: "Address Cluster:",
                value: outletData['address_cluster'] ?? '',
              ),
              CustomTextField(
                label: "Address Area:",
                value: outletData['address_area'] ?? '',
              ),
              CustomTextField(
                label: "Address Region:",
                value: outletData['address_region'] ?? '',
              ),
              CustomTextField(
                label: "Owner Type:",
                value: outletData['owner_type'] ?? '',
              ),
              CustomTextField(
                label: "Owner Name:",
                value: outletData['owner_name'] ?? '',
              ),
              CustomTextField(
                label: "Owner Contact Number 1:",
                value: outletData['owner_contact_number_1'] ?? '',
              ),
              CustomTextField(
                label: "Owner Contact Number 2:",
                value: outletData['owner_contact_number_2'] ?? '',
              ),
              CustomTextField(
                label: "Owner Bkash Number:",
                value: outletData['owner_bkash_number'] ?? '',
              ),
              CustomTextField(
                label: "Contact Person Name:",
                value: outletData['contact_person_name'] ?? '',
              ),
              CustomTextField(
                label: "Contact Person Mobile:",
                value: outletData['contact_person_mobile'] ?? '',
              ),
              CustomTextField(
                label: "Owner of Bkash for Transaction Number:",
                value: outletData['owner_of_bkash_for_transaction_number'] ?? '',
              ),
              CustomTextField(
                label: "Trade License Availability:",
                value: outletData['has_trade_license'] ?? '',
              ),
              CustomTextField(
                label: "Average Consumer Footfall Per Day:",
                value: outletData['average_consumer_footfall_per_day'] ?? '',
              ),
              CustomTextField(
                label: "Weekly Off Days:",
                value: outletData['weekly_off_days'] ?? '',
              ),
              CustomTextField(
                label: "Open Time:",
                value: outletData['open_time'] ?? '',
              ),
              CustomTextField(
                label: "Close Time:",
                value: outletData['close_time'] ?? '',
              ),
              CustomTextField(
                label: "Top 5 Brands 1:",
                value: outletData['top_5_brands_1'] ?? '',
              ),
              CustomTextField(
                label: "Top 5 Brands 2:",
                value: outletData['top_5_brands_2'] ?? '',
              ),
              CustomTextField(
                label: "Top 5 Brands 3:",
                value: outletData['top_5_brands_3'] ?? '',
              ),
              CustomTextField(
                label: "Top 5 Brands 4:",
                value: outletData['top_5_brands_4'] ?? '',
              ),
              CustomTextField(
                label: "Top 5 Brands 5:",
                value: outletData['top_5_brands_5'] ?? '',
              ),
              CustomTextField(
                label: "Is Internet Hardware Available:",
                value: outletData['is_available_internet_hardware'] ?? '',
              ),
              CustomTextField(
                label: "Is CCTV Available:",
                value: outletData['is_available_cctv'] ?? '',
              ),
              CustomTextField(
                label: "CCTV Monitor Placed Location:",
                value: outletData['cctv_monitor_placed_location'] ?? '',
              ),
              CustomTextField(
                label: "Available Places to Mount the Display:",
                value: outletData['available_places_to_mount_the_display'] ?? '',
              ),
              CustomTextField(
                label: "Is It Going to be Placed Any Corner:",
                value: outletData['is_going_to_be_placed_any_corner'] ?? '',
              ),
              CustomTextField(
                label: "Will Display be Placed at Eyelevel:",
                value: outletData['will_display_be_placed_at_eyelevel'] ?? '',
              ),
              CustomTextField(
                label: "Is Retailer Happy with Incentive Offered:",
                value: outletData['is_retailer_happy_with_incentive_offered'] ?? '',
              ),
              CustomTextField(
                label: "Incentive Demand by Retailer:",
                value: outletData['what_incentive_demand'] ?? '',
              ),
              CustomTextField(
                label: "Largest Amount of Incentive He/She Gets:",
                value: outletData['largest_amount_of_incentive_het_gets'] ?? '',
              ),
              CustomTextField(
                label: "Who is the Client:",
                value: outletData['who_is_the_client'] ?? '',
              ),
              CustomTextField(
                label: "Average Daily Sales:",
                value: outletData['average_daily_sales'] ?? '',
              ),
              CustomTextField(
                label: "Retail Category:",
                value: outletData['retail_category'] ?? '',
              ),
              CustomTextField(
                label: "Retail Type:",
                value: outletData['retail_type'] ?? '',
              ),
              CustomTextField(
                label: "Premises:",
                value: outletData['premises'] ?? '',
              ),
              CustomTextField(
                label: "Market Name:",
                value: outletData['market_name'] ?? '',
              ),
              // CustomTextField(
              //   label: "Created By:",
              //   value: outletData['created_by'] ?? '',
              // ),
              // CustomTextField(
              //   label: "User Name:",
              //   value: outletData['user_name'] ?? '',
              // ),
              CustomTextField(
                label: "Latitude Value:",
                value: outletData['lat_value'] ?? '',
              ),
              CustomTextField(
                label: "Longitude Value:",
                value: outletData['lon_value'] ?? '',
              ),
              CustomTextField(
                label: "Accuracy:",
                value: outletData['accuracy'] ?? '',
              ),
              // CustomTextField(
              //   label: "Remarks:",
              //   value: outletData['remarks'] ?? '',
              // ),
              CustomTextField(
                label: "Create Date:",
                value: outletData['create_date'] ?? '',
              ),
              CustomTextField(
                label: "Create Time:",
                value: outletData['create_time'] ?? '',
              ),
              Center(
                child: Column(
                  children: outletData['outletImage'].map<Widget>((image) {
                    String imageUrl = '';
                    String label = '';
                    switch (image['image_type_id']) {
                      case '4':
                        label = 'Retail with Billboard';
                        imageUrl = 'http://retail.isgalleon.com/images/retail/retail_with_billboard/${image['name']}';
                        break;
                      case '5':
                        label = 'Installation picture 1';
                        imageUrl = 'http://retail.isgalleon.com/images/retail/installation1/${image['name']}';
                        break;
                      case '6':
                        label = 'Installation picture 2';
                        imageUrl = 'http://retail.isgalleon.com/images/retail/installation2/${image['name']}';
                        break;
                      default:
                      // Handle other cases if necessary
                        imageUrl = ''; // Or provide a default image URL
                    }
                    if(imageUrl == '')return SizedBox.shrink();
                    return Column(
                      children: [
                        SizedBox(
                          height: 10.h,
                        ),
                        SizedBox(
                          //width: 150.w,
                          child: Text(
                            label,
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        SizedBox(
                            height: 200.h,
                            width: MediaQuery.of(context).size.width*0.8,
                            child: Image.network(imageUrl,fit: BoxFit.cover,)
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),

    );
  }
}
