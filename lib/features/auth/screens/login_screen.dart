import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/features/auth/services/firebase_auth_methods.dart';
import 'package:shop_app/features/user/controller/firebase_user.dart';
import 'package:shop_app/core/common/loader.dart';
import 'package:shop_app/core/constants/constants.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final phoneController = TextEditingController();
  bool isLoading = false;

  @override
  void dispose() {
    super.dispose();
    phoneController.dispose();
  }

  @override
  void initState() {
    createUserDocument();
    print(FirebaseAuth.instance.currentUser);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 183, 187, 189),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Text(
              //   'Foot Fit',
              //   style: Theme.of(context).textTheme.titleLarge,
              // ),
              Image(
                image: AssetImage('assets/images/app_logo_white.png'),
                width: 120,
                height: 120,
              ),
              const Spacer(),
              Card(
                color: Colors.white,
                elevation: 5,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Your Phone',
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Phone Number',
                            style: Theme.of(context).textTheme.titleSmall,
                          )),
                      Row(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(right: 10),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: 10,
                                  child: Image.asset(
                                    Constants.counrtyLogo,
                                    fit: BoxFit.cover,
                                    width: 24,
                                    height: 24,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const VerticalDivider(
                            color: Colors.grey,
                            thickness: 1,
                          ),
                          Expanded(
                            child: TextField(
                              controller: phoneController,
                              keyboardType: TextInputType.phone,
                              decoration: const InputDecoration(
                                hintText: 'Enter your phone number',
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                          'A 4 digit OTP will be sent via SMS to verify\nyour mobile number!'),
                      const SizedBox(
                        height: 20,
                      ),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: TextButton.icon(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            label: const Text('BACK'),
                            icon: const Icon(
                              Icons.arrow_left_outlined,
                            )),
                      )
                    ],
                  ),
                ),
              ),
              const Spacer(),
              isLoading
                  ? const Loader()
                  : ElevatedButton(
                      onPressed: () {
                        setState(() {
                          isLoading = false;
                        });
                        FirebaseAuthMethods(FirebaseAuth.instance)
                            .phoneSignIn(context, phoneController.text, () {
                          setState(() {});
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 40),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        'Continue',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
              const SizedBox(
                height: 30,
              )
            ],
          ),
        ),
      ),
    );
  }
}
