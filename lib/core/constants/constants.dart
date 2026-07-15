import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:legal_tech/core/constants/app_colors.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

List<int> calculateRoundedPercentages(List<int> values) {
  int total = values.reduce((a, b) => a + b);
  return values.map((value) => ((value / total) * 100).round()).toList();
}

void myPrint(dynamic data) {
  debugPrint(data.toString());
}

Future<DateTime?> showMyDatePicker(
    BuildContext context, DateTime dateTime) async {
  return await showDatePicker(
    context: context,
    initialDate: dateTime,
    firstDate: DateTime(2000),
    lastDate: DateTime(2101),
  );
}

Future<TimeOfDay?> showTimePickerDialog({
  required BuildContext context,
  required TimeOfDay initialTime,
}) async {
  final pickedTime = await showTimePicker(
    context: context,
    initialTime: initialTime,
    builder: (BuildContext context, Widget? child) {
      return Theme(
        data: ThemeData.light().copyWith(
          primaryColor: AppColors.navy,
          buttonTheme: const ButtonThemeData(
            textTheme: ButtonTextTheme.primary,
          ),
          colorScheme:
              const ColorScheme.light(primary: AppColors.navy).copyWith(
            secondary: AppColors.navy,
          ),
        ),
        child: child!,
      );
    },
  );
  return pickedTime;
}


class TimeOutConstants {
  static int connectTimeout = 30;
  static int receiveTimeout = 25;
  static int sendTimeout = 60;
}

class MyCircularProgressIndicator extends StatelessWidget {
  const MyCircularProgressIndicator({
    super.key,
    this.radius = 10,
    this.color,
  });

  final double radius;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CupertinoActivityIndicator(
        radius: radius,
        color: color ?? AppColors.navy,
      ),
    );
  }
}



// String mainBaseUrl = dotenv.get("baseUrl", fallback: "");
String mapKey= "581bf156-762e-49cf-9698-795797b7f317";

