import "package:flutter/material.dart";
import "package:page_transition/page_transition.dart";
import "package:wordpress_app/api/api_service.dart";
import "package:wordpress_app/constants/constants.dart";
import "package:wordpress_app/models/woocommerece/register_model.dart";
import "package:wordpress_app/ui/signup/custom_form_field.dart";
import "package:wordpress_app/ui/utils/custom_app_bar.dart";
import "package:wordpress_app/ui/utils/extentions.dart";
import "package:wordpress_app/ui/utils/custom_dialog_box.dart";
import 'package:wordpress_app/ui/login_page/login_page.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  late APIService apiService;
  late CustomerModel customerModel;

  GlobalKey<FormState> globalKey = GlobalKey<FormState>();

  bool isApiCalled = false;

  Widget loading(bool X) {
    if (X) {
      return CircularProgressIndicator();
    } else {
      return Text('');
    }
  }

  @override
  void initState() {
    apiService = APIService();
    customerModel = CustomerModel();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          CustomAppBar(title: "ثبت نام"),
          Positioned(
            top: 130,
            left: 20,
            right: 20,
            child: SizedBox(
              height: size.height * .8,
              width: size.width * .8,
              child: Form(
                key: globalKey,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        CustomFormField(
                          labelName: "نام",
                          initialValue: customerModel.firstName,
                          textAlign: TextAlign.right,
                          onChanged: (String value) {
                            customerModel.firstName = value;
                          },
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return "این فیلد نمیتواند خالی باشد";
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 30),
                        CustomFormField(
                          labelName: " نام خانوادگی",
                          initialValue: customerModel.lastName,
                          textAlign: TextAlign.right,
                          onChanged: (String value) {
                            customerModel.lastName = value;
                          },
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return "این فیلد نمیتواند خالی باشد";
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 30),
                        CustomFormField(
                          labelName: "ایمیل",
                          initialValue: customerModel.email,
                          textAlign: TextAlign.left,
                          onChanged: (String value) {
                            customerModel.email = value;
                          },
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return "این فیلد نمیتواند خالی باشد";
                            } else {
                              if (!value.isValidEmail) {
                                return "ایمیل را درست وارد کنید";
                              }
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 30),
                        CustomFormField(
                          labelName: "پسورد",
                          initialValue: customerModel.password,
                          textAlign: TextAlign.left,
                          onChanged: (String value) {
                            customerModel.password = value;
                          },
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return "این فیلد نمیتواند خالی باشد";
                            }
                            if (!value.isValidPassword) {
                              return "رمز باید شامل حروف بزرگ و کوچک و همچنین مواردی چون @ ! و.. باشد";
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 30),
                        Row(
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Constants.primaryColor,
                                padding: EdgeInsets.symmetric(
                                  horizontal: 30,
                                  vertical: 12,
                                ),
                              ),
                              onPressed: () {
                                debugPrint('${customerModel.toJson()}');
                                if (globalKey.currentState!.validate()) {
                                  setState(() => isApiCalled = true);
                                  apiService.createCustomer(customerModel).then(
                                    (x) {
                                      if (x) {
                                        CustomDialogBox.showMessage(
                                          context,
                                          "ثبت نام موفق",
                                          "ثبت نام با موفقیت انجام شد",
                                          "بستن",
                                          () {
                                            Navigator.of(context).pop();
                                          },
                                        );
                                      } else {
                                        CustomDialogBox.showMessage(
                                          context,
                                          "ثبت نام ناموفق",
                                          "ثبت نام شما انجام نشد",
                                          "بستن",
                                          () {
                                            Navigator.of(context).pop();
                                          },
                                        );
                                      }
                                      setState(() => isApiCalled = false);
                                    },
                                  );
                                }
                              },
                              child: Text(
                                "ثبت نام",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "yekan",
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            SizedBox(width: 20),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Constants.primaryColor,
                                padding: EdgeInsets.symmetric(
                                  horizontal: 30,
                                  vertical: 12,
                                ),
                              ),
                              onPressed: () {
                                Navigator.of(context).pushReplacement(
                                  PageTransition(
                                    type: PageTransitionType.leftToRight,
                                    child: LoginPage(),
                                  ),
                                );
                              },
                              child: Text(
                                "قبلاً اکانت ساختی؟",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "yekan",
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 30),
                        loading(isApiCalled),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
