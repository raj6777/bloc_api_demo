import 'package:api_calling_bloc_mvvm_demo/bloc/login/login_bloc.dart';
import 'package:api_calling_bloc_mvvm_demo/bloc/login/login_event.dart';
import 'package:api_calling_bloc_mvvm_demo/presentation/HomeScreen.dart';
import 'package:api_calling_bloc_mvvm_demo/presentation/user_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/login/login_state.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Login")),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocBuilder<LoginBloc, LoginState>(
          builder: (context, state) {
            if (state is UserLoadig) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is LoginUser) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Login successful')),
                );
                context.read<LoginBloc>().add(
                      LoginEventDetail(
                        email: "",
                        password: "",
                      ),
                    );
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => Homescreen()),
                );
              });
            }

            if (state is UserError) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.message)),
                );
              });
            }

            return Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Center(
                    child: Text(
                      "Login",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      hintText: "Email",
                      labelText: "Enter Email",
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Email cannot be empty';
                      }
                      final emailRegEx = RegExp(r'^[^@]+@[^@]+\.[^@]+');
                      if (!emailRegEx.hasMatch(value)) {
                        return 'Enter a valid email address';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: passwordController,
                    decoration: const InputDecoration(
                      hintText: "Password",
                      labelText: "Enter Password",
                      border: OutlineInputBorder(),
                    ),
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Password cannot be empty';
                      }
                      if (value.length < 6) {
                        return 'Password must be at least 6 characters long';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        context.read<LoginBloc>().add(
                              LoginEventDetail(
                                email: emailController.text,
                                password: passwordController.text,
                              ),
                            );
                      }
                    },
                    child: const Text("Login"),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
