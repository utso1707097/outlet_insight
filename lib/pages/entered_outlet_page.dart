import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:outlet_insight/pages/show_outlage_page.dart';
import 'package:outlet_insight/utils/custom_loading_indicator.dart';

import '../utils/custom_alert_dialog.dart';
import '../utils/custom_drawer.dart';

class EnteredOutletPage extends StatelessWidget {
  final String userId;

  const EnteredOutletPage({Key? key, required this.userId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
      drawer: const CustomDrawer(),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: fetchEnteredOutlets(context, userId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CustomLoadingIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final enteredOutlets = snapshot.data!;
            return ListView.builder(
              itemCount: enteredOutlets.length,
              itemBuilder: (context, index) {
                final outlet = enteredOutlets[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF0273FD), Color(0xFF00D0FF)],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: GestureDetector(
                      onTap: () async{
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return CustomLoadingIndicator();
                          },
                        );
                        final outletData = await fetchSelectedOutlet(context, userId, outlet['id']);
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>
                              ShowOutletPage(outletData: outletData)),
                        );
                      },
                      child: ListTile(
                        title: Text(
                          outlet['name'] ?? '',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white, // Title text color
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              outlet['owner_name'] ?? '',
                              // Adding ?? '' to handle null values
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: Colors.white70.withOpacity(
                                    0.8), // Subtitle text color
                              ),
                            ),
                            SizedBox(height: 5.h,),
                            Text(
                              outlet['owner_contact_number_1'] ?? '',
                              // Adding ?? '' to handle null values
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: Colors.white70.withOpacity(
                                    0.8), // Subtitle text color
                              ),
                            ),
                          ],
                        ),
                        leading: Container(
                          width: 70.w,
                          height: 70.h,
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            // Background color of leading icon
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(
                              outlet['name'].substring(0, 1).toUpperCase(),
                              style: TextStyle(
                                fontSize: 20.sp,
                                color: Colors
                                    .white, // Color of leading icon text
                              ),
                            ),
                          ),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios, // Example of a trailing icon
                          color: Colors.white, // Color of trailing icon
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

  Future<List<Map<String, dynamic>>> fetchEnteredOutlets(BuildContext context,
      String userId) async {
    try {
      // Your API endpoint for leave applications
      final String leaveApplicationsUrl =
          'http://retail.isgalleon.com/api/outlet/get_outlet.php';
      final Uri uri = Uri.parse(leaveApplicationsUrl);

      final map = <String, dynamic>{};
      // Assuming you have SharedPreferences initialized
      map['UserId'] = userId;
      map['ResponseType'] = "list";
      map['TargetUserId'] = userId;

      final http.Response response = await http.post(
        uri,
        body: map,
      );

      print("Request data: $map");
      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        print('Response data: $responseData');

        if (responseData.containsKey('outletResult') &&
            responseData['outletResult'] != null) {
          List<Map<String, dynamic>> outletList =
          (responseData['outletResult'] as List<dynamic>)
              .map((item) => Map<String, dynamic>.from(item))
              .toList();
          // Sort the outletList by the 'submit_date' field
          // outletList.sort((a, b) => DateTime.parse(b['submit_date']).compareTo(DateTime.parse(a['submit_date'])));
          return outletList;
        } else {
          // Handle case where 'outletList' is null or not present
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return CustomAlertDialog(
                title: "Error",
                message: "Failed to load leave applications. 'outletList' is null or not present in the response.",
              );
            },
          );
          return [];
        }
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return CustomAlertDialog(
              title: "Error",
              message: "Failed to load Outlet List. Status code: ${response
                  .statusCode}",
            );
          },
        );
        return [];
      }
    } catch (error) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return CustomAlertDialog(
            title: "Error",
            message: "Error loading outlet List: $error",
          );
        },
      );
      return [];
    }
  }

  Future<Map<String, dynamic>> fetchSelectedOutlet(BuildContext context, String userId, String outletId) async {
    try {
      // Your API endpoint for leave applications
      final String leaveApplicationsUrl = 'http://retail.isgalleon.com/api/outlet/get_outlet.php';
      final Uri uri = Uri.parse(leaveApplicationsUrl);

      final map = <String, dynamic>{};
      // Assuming you have SharedPreferences initialized
      map['UserId'] = userId;
      map['ResponseType'] = "list";
      map['TargetUserId'] = userId;
      map['OutletId'] = outletId;

      final http.Response response = await http.post(
        uri,
        body: map,
      );

      print("Request data: $map");
      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        print('Response data: $responseData');

        if (responseData.containsKey('outletResult') && responseData['outletResult'] != null) {
          Map<String, dynamic> outletData = Map<String, dynamic>.from(responseData['outletResult']);
          return outletData;
        } else {
          // Handle case where 'outletResult' is null or not present
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return CustomAlertDialog(
                title: "Error",
                message: "Failed to load outlet data. 'outletResult' is null or not present in the response.",
              );
            },
          );
          return {};
        }
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return CustomAlertDialog(
              title: "Error",
              message: "Failed to load Outlet data. Status code: ${response.statusCode}",
            );
          },
        );
        return {};
      }
    } catch (error) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return CustomAlertDialog(
            title: "Error",
            message: "Error loading outlet data: $error",
          );
        },
      );
      return {};
    }
  }

}