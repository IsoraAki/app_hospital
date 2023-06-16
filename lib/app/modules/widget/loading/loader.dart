import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_app_hospital/app/modules/widget/loading/loader_color.dart';
import 'package:my_app_hospital/configs/app_color.dart';

class Load {
  Widget loadingData(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width.w,
      alignment: AlignmentDirectional.center,
      // decoration: BoxDecoration(
      //   color: AppColors.white,
      // ),
      child: Container(
        alignment: AlignmentDirectional.center,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Center(
              child: SizedBox(height: 50.0, width: 50.0, child: LoaderColor(radius: 13.0, dotRadius: 4.0)),
            ),
            Center(
              child: Text(
                "Loading....",
                style: TextStyle(fontSize: 13, color: AppColors.hintText),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget loading(
    BuildContext context,
  ) {
    return Center(
      child: SizedBox(
          height: 40.0,
          width: 40.0,
          child: LoaderColor(
            radius: 13.0,
            dotRadius: 4.0,
          )),
    );
  }
}
