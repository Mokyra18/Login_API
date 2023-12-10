import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'home_page.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  Future<void> login(String username, String password) async {
    final apiUrl = 'https://dev.uinsgd.site/api/index.php/mhs/login';
    final response = await http.post(Uri.parse(apiUrl), body: {
      'username': username,
      'password': password,
    });
// print(response);
    if (response.statusCode == 200) {
//mengambil data token
      final token = json.decode(response.body)['token'];
//mengabil data user
      final user = json.decode(response.body)['user'];
      final akm = json.decode(response.body)['akm'];
//berpindah halaman
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(
            id: user['id'],
            name: user['name'],
            foto: user['foto'],
            email: user['email'],
            token: token,
            jurusan: user['jurusan'],
            fakultas: user['fakultas'],
            angkatan: user['angkatan'],
            akm: akm,
          ),
        ),
        (route) => false,
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Login Failed'),
            content: Text('Invalid email or password.'),
            actions: <Widget>[
// ignore: deprecated_member_use
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login SALAM'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Image(
              width: 300,
              image: NetworkImage(
                  'https://salam.uinsgd.ac.id/dashboard/assets/logo_salam.png'),
            ),
            SizedBox(
              height: 16,
            ),
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Username',
              ),
            ),
            TextFormField(
              controller: passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
              ),
              obscureText: true,
            ),
            SizedBox(height: 16.0),
// ignore: deprecated_member_use
            ElevatedButton(
              child: Text('Login'),
              onPressed: () {
                Loader.show(context,
                    isAppbarOverlay: false,
                    overlayFromTop: 100,
                    progressIndicator: CircularProgressIndicator(),
                    themeData: Theme.of(context).copyWith(
                        colorScheme: ColorScheme.fromSwatch()
                            .copyWith(secondary: Colors.black38)),
                    overlayColor: Color(0x99E8EAF6));

                ///loader hide after 3 seconds

                Future.delayed(Duration(seconds: 2), () {
                  Loader.hide();
                  login(emailController.text, passwordController.text);
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
