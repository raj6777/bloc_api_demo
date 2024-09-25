import 'package:api_calling_bloc_mvvm_demo/bloc/api_bloc.dart';
import 'package:api_calling_bloc_mvvm_demo/presentation/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final apiBloc = BlocProvider.of<ApiBloc>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("User List")),
      body: BlocBuilder<ApiBloc, ApiState>(
        bloc: apiBloc,
        builder: (context, state) {
          if (state is UserLoadig) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is NewsLoaded) {
            final users = state.newsData.articles;
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: users.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            users[index].urlToImage != null
                                ? Image.network(
                                    users[index].urlToImage!,
                                    width: MediaQuery.of(context).size.width,
                                    height: 200.0,
                                    fit: BoxFit.cover,
                                  )
                                : Image.asset(
                                    'assets/news.png',
                                    width: MediaQuery.of(context).size.width,
                                    height: 200.0,
                                    fit: BoxFit.cover,
                                  ),
                            Text(
                              users[index].title,
                              style: const TextStyle(
                                  fontSize: 18.0, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              users[index].description ?? "",
                              style: const TextStyle(fontSize: 12.0),
                            ),
                            Text(
                              users[index].url ?? "",
                              style: const TextStyle(
                                  fontSize: 12.0,
                                  color: Colors.lightBlue,
                                  decoration: TextDecoration.underline),
                            ),
                            Text(
                              users[index].content ?? "",
                              style: const TextStyle(fontSize: 12.0),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    textAlign: TextAlign.end,
                                    " - ${users[index].author ?? ""}",
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    final prefs = await SharedPreferences.getInstance();
                    await prefs.remove('isLogin');
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                  },
                  child: const Text("Logout"),
                ),
              ],
            );
          } else if (state is UserError) {
            return Center(child: Text(state.message));
          }
          return const Center(child: Text("No Users"));
        },
      ),
    );
  }
}
