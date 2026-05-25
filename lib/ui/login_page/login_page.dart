import "package:flutter/material.dart";
import "package:page_transition/page_transition.dart";
import "package:wordpress_app/api/api_service.dart";
import "package:wordpress_app/constants/constants.dart";
import "package:wordpress_app/models/woocommerece/login_model.dart";
import "package:wordpress_app/models/woocommerece/register_model.dart";
import "package:wordpress_app/ui/home/home.dart";
import "package:wordpress_app/ui/root/root.dart";
import "package:wordpress_app/ui/signup/signup_page.dart";
import "package:wordpress_app/ui/utils/custom_app_bar.dart";
import "package:wordpress_app/ui/utils/custom_dialog_box.dart";

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late APIService apiService;
  late CustomerModel customerModel;
  late LoginResponseModel loginModel;
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController(
    text: "az@ex.com",
  );
  TextEditingController passwordController = TextEditingController(
    text: "Az@1493@az",
  );

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
    loginModel = LoginResponseModel();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          CustomAppBar(title: " ورود به برنامه"),
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
                        Directionality(
                          textDirection: .rtl,
                          child: TextFormField(
                            controller: emailController,
                            textDirection: TextDirection.ltr,
                            cursorColor: Constants.primaryColor,
                            decoration: InputDecoration(
                              errorStyle: TextStyle(
                                fontFamily: "yekan",
                                fontSize: 12,
                              ),
                              border: OutlineInputBorder(),
                              label: Text(
                                "ایمیل",
                                style: TextStyle(
                                  fontFamily: "laleh",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Constants.primaryColor,
                                ),
                              ),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "این فیلد نمیتواند خالی باشد";
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(height: 30),
                        Directionality(
                          textDirection: .rtl,
                          child: TextFormField(
                            controller: passwordController,
                            textDirection: TextDirection.ltr,
                            cursorColor: Constants.primaryColor,
                            decoration: InputDecoration(
                              errorStyle: TextStyle(
                                fontFamily: "yekan",
                                fontSize: 12,
                              ),
                              border: OutlineInputBorder(),
                              label: Text(
                                "پسورد",
                                style: TextStyle(
                                  fontFamily: "laleh",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Constants.primaryColor,
                                ),
                              ),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "این فیلد نمیتواند خالی باشد";
                              }
                              return null;
                            },
                          ),
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
                                if (globalKey.currentState!.validate()) {
                                  setState(() => isApiCalled = true);

                                  apiService
                                      .login(
                                        emailController.text,
                                        passwordController.text,
                                      )
                                      .then((x) {
                                        setState(() => isApiCalled = false);
                                        if (x.success!) {
                                          debugPrint(x.token);
                                          debugPrint(x.toString());
                                          CustomDialogBox.showMessage(
                                            context,
                                            "موفقیت آمیز",
                                            "اکانت شما با موفقیت شناسایی شد",
                                            "ورود به برنامه",
                                            () {
                                              Navigator.of(
                                                context,
                                              ).pushReplacement(
                                                PageTransition(
                                                  type: PageTransitionType
                                                      .leftToRight,
                                                  child: RootPage(),
                                                ),
                                              );
                                            },
                                          );
                                        } else {
                                          CustomDialogBox.showMessage(
                                            context,
                                            "  ناموفق",
                                            "انجام نشد",
                                            "بستن",
                                            () {
                                              Navigator.of(context).pop();
                                            },
                                          );
                                        }
                                        setState(() => isApiCalled = false);
                                      });
                                }
                              },
                              child: Text(
                                "ورود",
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
                                    child: SignupPage(),
                                  ),
                                );
                              },
                              child: Text(
                                "اکانت ندارید؟",
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
