import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:my_app_hospital/app/modules/widget/custom_text.dart';
import 'package:my_app_hospital/app/routes/app_pages.dart';
import 'package:my_app_hospital/configs/app_color.dart';
import 'package:my_app_hospital/configs/theme/dimens.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  LoginView({Key? key}) : super(key: key);
  final TextEditingController _pwdController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  //final snackBar = SnackBar(content: Text('email ou mot de passe incorrect'));
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    const double r = (175 / 360); //  rapport for web test(304 / 540);
    final coverHeight = screenWidth * r;
    bool _pinned = false;
    bool _snap = false;
    bool _floating = false;

    final widgetList = [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TweenAnimationBuilder(
            tween: Tween<double>(begin: 0, end: 1),
            duration: Duration(milliseconds: 500),
            //curve: Curves.bounceIn,
            builder: (BuildContext context, double size, Widget? child) {
              return Opacity(
                opacity: size,
                child: Padding(
                  padding: EdgeInsets.only(top: size * 20),
                  child: const Text(
                    'Đăng nhập',
                    style: TextStyle(
                      fontFamily: 'Segoe UI',
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0F99E9),
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
              );
            },
          ),
        ],
      ),
      SizedBox(
        height: size_25_h,
      ),
      Form(
          key: _formKey,
          child: Column(
            children: [
              TweenAnimationBuilder(
                tween: Tween<double>(begin: 0, end: 1),
                duration: Duration(milliseconds: 500),
                builder: (BuildContext context, double size, Widget? child) {
                  var zoom = 1 - size;
                  return Opacity(
                      opacity: size,
                      child: Padding(
                        padding: EdgeInsets.only(left: (zoom * 20) + 20, right: (zoom * 20) + 20),
                        child: CustomTextField(
                          controller: TextEditingController(),
                          typeInput: TypeInput.text,
                          lableText: 'Tên đăng nhập',
                          hideText: 'Nhập tên đăng nhập',
                          prefixIcon: Icon(Icons.account_box_sharp),
                          //validator: (value) => Validator.validateEmail(value),
                        ),
                      ));
                },
              ),
              TweenAnimationBuilder(
                tween: Tween<double>(begin: 0, end: 1),
                duration: Duration(milliseconds: 500),
                builder: (BuildContext context, double size, Widget? child) {
                  return Opacity(
                    opacity: size,
                    child: Padding(
                      padding: EdgeInsets.only(left: size * 20, right: size * 20),
                      child: CustomTextField(
                        controller: TextEditingController(),
                        typeInput: TypeInput.password,
                        lableText: 'Mật khẩu',
                        hideText: '*********',
                        prefixIcon: Icon(Icons.key),
                        //validator: (value) => Validator.checkPassword(value),
                      ),
                    ),
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.only(right: 25.0, top: 10.0),
                child: Align(
                    alignment: Alignment.topRight,
                    child: Material(
                      color: Colors.transparent,
                      child: CheckboxListTile(
                        controlAffinity: ListTileControlAffinity.leading,
                        activeColor: Colors.blue[400],
                        checkColor: Colors.white,
                        title: const Text(
                          'Ghi nhớ thông tin',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        value: true,
                        onChanged: (bool? value) {},
                      ),
                    )),
              ),
              SizedBox(
                height: size_25_h,
              ),
              TweenAnimationBuilder(
                tween: Tween<double>(begin: 0, end: 1),
                duration: Duration(milliseconds: 500),
                builder: (BuildContext context, double size, Widget? child) {
                  return Opacity(
                    opacity: size,
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: size * 20,
                      ),
                      child: SizedBox(
                        height: 55.0,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              print("I ove tunisia");
                            }
                            Get.toNamed(Routes.BOTTOM_BAR);
                          },
                          style: ElevatedButton.styleFrom(
                            primary: AppColors.background,
                            elevation: 0.0,
                            minimumSize: Size(screenWidth, 150),
                            padding: EdgeInsets.symmetric(horizontal: 30),
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(0)),
                            ),
                          ),
                          child: Ink(
                            decoration: BoxDecoration(
                                boxShadow: const <BoxShadow>[
                                  BoxShadow(color: Colors.blue, offset: Offset(1.1, 1.1), blurRadius: 10.0),
                                ],
                                color: Colors.blue[400], // Color(0xffF05945),
                                borderRadius: BorderRadius.circular(12.0)),
                            child: Container(
                              alignment: Alignment.center,
                              child: const Text(
                                "Đăng nhập",
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.white, fontSize: 25),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          )),
      SizedBox(
        height: size_25_h,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Image.asset(
            'assets/images/fb.png',
            width: 35,
          ),
          Image.asset(
            'assets/images/gg.png',
            width: 30,
          ),
          Image.asset(
            'assets/images/btncall.png',
            width: 35,
          ),
        ],
      ),
      const SizedBox(
        height: 15.0,
      ),
    ];
    return Scaffold(
      extendBodyBehindAppBar: true,
      //backgroundColor: Colors.white,
      appBar: AppBar(
        // leading: Icon(Icons.arrow_back),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: _pinned,
            snap: _snap,
            floating: _floating,
            expandedHeight: coverHeight, //304,
            backgroundColor: Colors.black,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              background: Image.asset("assets/images/bg1.jpg", fit: BoxFit.cover),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              decoration: const BoxDecoration(borderRadius: BorderRadius.only(), gradient: LinearGradient(colors: <Color>[Colors.black, Colors.black])),
              width: screenWidth,
              height: 25,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Container(
                    width: screenWidth,
                    height: 25,
                    decoration: const BoxDecoration(
                      color: AppColors.background,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30.0),
                        topRight: Radius.circular(30.0),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          SliverList(
              delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
            return widgetList[index];
          }, childCount: widgetList.length))
        ],
      ),
      // bottomNavigationBar: Stack(
      //   children: [
      //     new Container(
      //       height: 50.0,
      //       color: Colors.white,
      //       child: Center(
      //           child: Wrap(
      //         children: [
      //           Text(
      //             "Vous n'avez pas un compte?  ",
      //             style: TextStyle(color: Colors.grey[600], fontWeight: FontWeight.bold),
      //           ),
      //           Material(
      //               child: InkWell(
      //             onTap: () {
      //               print("sign up tapped");
      //               //Get.to(SignUpScreen());
      //             },
      //             child: Text(
      //               "Sign Up",
      //               style: TextStyle(
      //                 color: Colors.blue[400],
      //                 fontWeight: FontWeight.bold,
      //                 fontSize: 15,
      //               ),
      //             ),
      //           )),
      //         ],
      //       )),
      //     ),
      //   ],
      // ),
    );
  }
}