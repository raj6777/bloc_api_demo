import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/profile/profile_bloc.dart';
import '../bloc/profile/profile_event.dart';
import '../bloc/profile/profile_state.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController IdController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final profileBloc = BlocProvider.of<ProfileBloc>(context);

    // Trigger the profile fetch event when the screen is opened.
    profileBloc.add(FetchProfileEvent());

    return BlocBuilder<ProfileBloc, ProfileState>(
      bloc: profileBloc,
      builder: (context, state) {
        if (state is ProfileLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ProfileLoaded) {
          // Load the email into the TextEditingController when the state is loaded
          emailController.text = state.user.email;
          firstNameController.text = state.user.firstName;
          lastNameController.text = state.user.lastName;
          IdController.text = state.user.id.toString();
          return Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 64, horizontal: 16),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      _buildImageWidget(state.user.avatar),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: TextFormField(
                          controller: IdController,
                          decoration: const InputDecoration(
                            hintText: "Enter Id",
                            labelText: "Id",
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Id cannot be empty';
                            }
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: TextFormField(
                          controller: emailController,
                          decoration: const InputDecoration(
                            hintText: "Enter Email",
                            labelText: "Email",
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
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: TextFormField(
                          controller: firstNameController,
                          decoration: const InputDecoration(
                            hintText: "Enter First Name",
                            labelText: "First Name",
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'First Name cannot be empty';
                            }
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: TextFormField(
                          controller: lastNameController,
                          decoration: const InputDecoration(
                            hintText: "Enter Last Name",
                            labelText: "Last Name",
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Last Name cannot be empty';
                            }
                          },
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            /*           Navigator.pop(context);*/
                          }
                        },
                        child: const Text("Submit"),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        } else if (state is ProfileError) {
          return Center(child: Text(state.error));
        } else {
          return const Center(child: Text("No data available"));
        }
      },
    );
  }

  Widget _buildImageWidget(String path) {
    return ClipOval(
      child: SizedBox(
        width: 200,
        height: 200,
        child: path.startsWith('http') || path.startsWith('https')
            ? Image.network(
                path,
                fit: BoxFit.cover,
              )
            : Image.file(
                File(path),
                fit: BoxFit.cover,
              ),
      ),
    );
  }
}
