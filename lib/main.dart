import 'package:api_calling_bloc_mvvm_demo/bloc/api_bloc.dart';
import 'package:api_calling_bloc_mvvm_demo/bloc/api_event.dart';
import 'package:api_calling_bloc_mvvm_demo/repository/user_repository.dart';
import 'package:api_calling_bloc_mvvm_demo/userimpl/UserRepositoryImpl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const UserScreen(), // Capitalized class name
    );
  }
}

class UserScreen extends StatelessWidget {
  // Capitalized class name
  const UserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("User List")), // Added AppBar
      body: BlocProvider(
        create: (context) =>
            ApiBloc(userRepository: UserRepositoryImpl())..add(FetchNews()),
        child: BlocBuilder<ApiBloc, ApiState>(
          builder: (context, state) {
            if (state is UserLoadig) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is NewsLoaded) {
              final users = state.newsData.articles;
              return ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Image that takes the full width of the screen
                        users[index].urlToImage != null
                            ? Image.network(
                                users[index].urlToImage!,
                                width: MediaQuery.of(context)
                                    .size
                                    .width, // Full screen width
                                height: 200.0, // Set a fixed height
                                fit: BoxFit
                                    .cover, // Ensures the image fills the container properly
                              )
                            : Image.asset(
                                'assets/news.png',
                                width: MediaQuery.of(context)
                                    .size
                                    .width, // Full screen width
                                height:
                                    200.0, // Set a fixed height for the placeholder
                                fit: BoxFit.cover,
                              ),
                        Text(
                          users[index].title, // Title text
                          style: const TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          users[index].description??"", // Title text
                          style: const TextStyle(
                              fontSize: 12.0),
                        ),
                        Text(
                          users[index].url??"", // Title text
                          style: const TextStyle(
                              fontSize: 12.0,color: Colors.lightBlue,decoration: TextDecoration.underline,                                          ),
                        ),
                        Text(
                          users[index].content??"", // Title text
                          style: const TextStyle(
                            fontSize: 12.0,                                          ),
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                textAlign: TextAlign.end,
                               " - ${users[index].author??""}", // Title text
                                style: const TextStyle(
                                    fontSize: 14,fontWeight:  FontWeight.bold)),
                              ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              );
            } else if (state is UserError) {
              return Center(child: Text(state.message));
            }
            return const Center(child: Text("No Users"));
          },
        ),
      ),
    );
  }
}
