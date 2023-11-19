import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoes/models/auth/signup_model.dart';
import 'package:shoes/views/ui/auth/login.dart';
import '../../../controllers/login_provider.dart';
import '../../shared/shared.dart';

class Registration extends StatefulWidget {
  const Registration({super.key});

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController username = TextEditingController();

  bool validation = false;

  void formValidation() {
    if (email.text.isNotEmpty &&
        password.text.isNotEmpty &&
        username.text.isNotEmpty) {
      validation = true;
    } else {
      validation = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    var authNotifier = Provider.of<LoginNotifier>(context);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 50,
        backgroundColor: Colors.black,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: const BoxDecoration(
          image: DecorationImage(
            opacity: 0.5,
            image: AssetImage('assets/images/bg.jpg'),
          ),
        ),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            ReusableText(
              text: "Welcome!",
              style: appStyle(25, Colors.white, FontWeight.w600),
            ),
            ReusableText(
              text: "Fill in your details to login into your account",
              style: appStyle(12, Colors.white, FontWeight.normal),
            ),
            const SizedBox(
              height: 50,
            ),
            CustomTextField(
              keyboard: TextInputType.emailAddress,
              validator: (email) {
                if (email!.isEmpty && !email.contains("@")) {
                  return 'Please provide valid email';
                } else {
                  return null;
                }
              },
              hintText: "Username",
              controller: username,
            ),
            const SizedBox(
              height: 15,
            ),
            CustomTextField(
              keyboard: TextInputType.emailAddress,
              validator: (username) {
                if (username!.isEmpty) {
                  return 'Please provide valid username';
                } else {
                  return null;
                }
              },
              hintText: "Email",
              controller: email,
            ),
            const SizedBox(
              height: 15,
            ),
            CustomTextField(
              hintText: "Password",
              obscureText: authNotifier.isObsecure,
              controller: password,
              suffixIcon: GestureDetector(
                  onTap: () {
                    authNotifier.isObsecure = !authNotifier.isObsecure;
                  },
                  child: authNotifier.isObsecure
                      ? const Icon(Icons.visibility_off)
                      : const Icon(Icons.visibility)),
              validator: (password) {
                if (password!.isEmpty && password.length < 7) {
                  return 'Please too weak';
                } else {
                  return null;
                }
              },
            ),
            const SizedBox(
              height: 10,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()));
                },
                child: ReusableText(
                  text: "Login",
                  style: appStyle(12, Colors.white, FontWeight.normal),
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            GestureDetector(
              onTap: () {
                formValidation();
                if (validation) {
                  SignupModel model = SignupModel(
                      username: username.text,
                      email: email.text,
                      password: password.text);
                  authNotifier.registerUser(model).then((response) {
                    if (response == true) {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => const LoginPage()));
                    } else {
                      debugPrint('Failed to sign up');
                    }
                  });
                } else {
                  debugPrint('form not valid');
                }
              },
              child: Container(
                height: 60,
                width: 300,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                child: Center(
                  child: ReusableText(
                    text: "S I G N U P",
                    style: appStyle(16, Colors.black, FontWeight.bold),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
