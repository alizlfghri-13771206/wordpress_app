import "package:flutter/material.dart";
import "package:wordpress_app/api/api_service.dart";
import "package:wordpress_app/constants/constants.dart";
import "package:wordpress_app/models/woocommerece/register_model.dart";
import "package:wordpress_app/ui/signup/custom_form_field.dart";

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
          Positioned(
            top: 40,
            left: 20,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // X Button
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      color: Constants.primaryColor.withValues(alpha: .3),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.close, color: Constants.primaryColor),
                  ),
                ),
                // Like Button
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      color: Constants.primaryColor.withValues(alpha: .2),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.share, color: Constants.primaryColor),
                  ),
                ),
              ],
            ),
          ),
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
                                  apiService.createCustomer(customerModel).then(
                                    (x) {
                                      if (x) {
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              title: Text('ووکامرس اپ'),
                                              content: Text('درسته'),
                                              actions: [
                                                ElevatedButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: Text("ok"),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      } else {
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              title: Text('ووکامرس اپ'),
                                              content: Text('ارور'),
                                              actions: [
                                                ElevatedButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: Text("ok"),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      }
                                    },
                                  );
                                } else {
                                  debugPrint("نام خالی");
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
                              onPressed: () {},
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
