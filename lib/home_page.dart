import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomePage extends StatefulWidget {
  final int id;
  final String name;
  final String foto;
  final String email;
  final String token;
  final String jurusan;
  final String fakultas;
  final String angkatan;
  final dynamic akm;
  HomePage(
      {required this.id,
      required this.name,
      required this.foto,
      required this.email,
      required this.token,
      required this.jurusan,
      required this.fakultas,
      required this.angkatan,
      required this.akm});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String formatAkm(dynamic akm) {
    try {
      final formattedAkm = JsonEncoder.withIndent('  ').convert(akm);
      return formattedAkm;
    } catch (e) {
      return '$akm';
    }
  }

  Future<void> handleLogout(String token) async {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: [
          IconButton(
            onPressed: () => handleLogout(this.widget.token),
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(), // or ClampingScrollPhysics()
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image(
                width: 100,
                image: NetworkImage('${this.widget.foto}'),
              ),
              Text('Welcome, ${this.widget.name}!'),
              SizedBox(height: 16.0),
              Text('Email: ${this.widget.email}'),
              SizedBox(height: 16.0),
              Text('Name: ${this.widget.name}'),
              SizedBox(height: 16.0),
              Text('Jurusan: ${this.widget.jurusan}'),
              SizedBox(height: 16.0),
              Text('Fakultas: ${this.widget.fakultas}'),
              SizedBox(height: 16.0),
              Text('Angkatan: ${this.widget.angkatan}'),
              SizedBox(height: 16.0),
              Text('Akademik : ${formatAkm(this.widget.akm)}'),
              SizedBox(height: 20.0),
            ],
          ),
        ),
      ),
    );
  }
}
