import 'package:flutter/material.dart';
import '../authentication/authentication_provider.dart';
import '../authentication/google/google_sign_in.dart';
import '../custom route/scale_route.dart';
import '../widgets/custom_elevated_button.dart';
import '../widgets/custom_elevated_button_gradient.dart';
import '../widgets/custom_input_button.dart';
import '../widgets/single_button_input.dart';
import 'log_in_screen.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  static const id = '/sign-up';

  const SignUpScreen({Key key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController fnameController = TextEditingController();
  final TextEditingController lnameController = TextEditingController();

  bool passwordVisibilitySignUp = true;
  bool loading = false;
  bool loading2 = false;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                children: [
                  SizedBox(
                    height: height / 15,
                  ),
                  Column(
                    children: [
                      const Text(
                        'Hey there!',
                        style: TextStyle(
                          color: Color(0xFF1D1617),
                          fontSize: 16.0,
                        ),
                      ),
                      const Text(
                        'Create an Account',
                        style: TextStyle(
                          color: Color(0xFF1D1617),
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 40.0,
                      ),
                      CustomInputButton(
                        controller: fnameController,
                        title: 'First Name',
                        textInputType: TextInputType.name,
                        prefixIconUrl: const Icon(
                          Icons.person_outlined,
                        ),
                        suffixIconUrl: const Visibility(
                          visible: false,
                          child: Icon(
                            Icons.person_outlined,
                          ),
                        ),
                        obscureText: false,
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      CustomInputButton(
                        controller: lnameController,
                        title: 'Last Name',
                        textInputType: TextInputType.name,
                        prefixIconUrl: const Icon(
                          Icons.person_outlined,
                        ),
                        suffixIconUrl: const Visibility(
                          visible: false,
                          child: Icon(
                            Icons.person_outlined,
                          ),
                        ),
                        obscureText: false,
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      SingleButtonInput(
                        controller: emailController,
                        textInputType: TextInputType.emailAddress,
                        title: 'Email',
                        prefixIconUrl: const Icon(
                          Icons.email_outlined,
                        ),
                        obscureText: false,
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      CustomInputButton(
                        controller: passwordController,
                        textInputType: TextInputType.visiblePassword,
                        obscureText: passwordVisibilitySignUp,
                        title: 'Password',
                        prefixIconUrl: const Icon(
                          Icons.password_outlined,
                        ),
                        suffixIconUrl: GestureDetector(
                          onTap: () {
                            setState(() {
                              passwordVisibilitySignUp = false;
                            });
                          },
                          child: Icon(
                            Icons.visibility_off_outlined,
                            color: passwordVisibilitySignUp == true
                                ? Colors.grey
                                : Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      loading
                          ? const CircularProgressIndicator()
                          : CustomElevatedButtonGradient(
                              width: double.infinity,
                              onPressed: () {
                                if (fnameController.text.isEmpty) {
                                  var snackBar = const SnackBar(
                                    content: Text('Enter all the Crediential'),
                                    backgroundColor: Colors.red,
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                } else if (lnameController.text.isEmpty) {
                                  var snackBar = const SnackBar(
                                    content: Text('Enter all the Crediential'),
                                    backgroundColor: Colors.red,
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                } else {
                                  setState(() {
                                    loading = true;
                                  });
                                  String fullName =
                                      "${fnameController.text} ${lnameController.text}";

                                  context.read<AuthenticationProvider>().signUp(
                                      name: fullName,
                                      email: emailController.text.trim(),
                                      password: passwordController.text.trim(),
                                      context: context);

                                  setState(() {
                                    loading = false;
                                  });
                                }
                              },
                              borderRadius: BorderRadius.circular(4.0),
                              child: const Text(
                                'Register',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.0,
                                ),
                              ),
                              height: 62.0,
                            ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      Image.asset('assets/images/or.png'),
                      const SizedBox(
                        height: 8.0,
                      ),
                      loading2
                          ? const CircularProgressIndicator()
                          : CustomElevatedButton(
                              child: SizedBox(
                                height: 40,
                                width: 40,
                                child: Image.asset(
                                  'assets/images/google.png',
                                ),
                              ),
                              bordRadious: 4.0,
                              height: 62.0,
                              color: Colors.white,
                              onPress: () async {
                                setState(() {
                                  loading2 = true;
                                });

                                await GoogleSignInMethod.signInWithGoogle();

                                setState(() {
                                  loading2 = false;
                                });
                              },
                              textColor: const Color(0xFFDA982A),
                            ),
                      const SizedBox(height: 20.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Already have an account? ',
                            style: TextStyle(
                              color: Color(0xFF1D1617),
                              fontSize: 14.0,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context, ScaleRoute(page: const LogIn()));
                            },
                            child: const Text(
                              ' Log In',
                              style: TextStyle(
                                color: Color(0xFF4BB845),
                                fontWeight: FontWeight.bold,
                                fontSize: 14.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
