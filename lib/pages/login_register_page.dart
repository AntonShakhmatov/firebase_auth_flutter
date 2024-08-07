import 'package:firebase_auth/firebase_auth.dart';
import 'package:munacha_app/auth.dart';
import 'package:flutter/material.dart';

class LoginRegisterPage extends StatefulWidget {

  const LoginRegisterPage({super.key});

  @override
  State<LoginRegisterPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginRegisterPage> {
  String? errorMessage = '';
  bool isLogin = true;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> signInWithEmailAndPassword() async{
    try{
      await Auth().signInWithEmailAndPassword(email: _emailController.text, password: _passwordController.text);
    } on FirebaseAuthException catch(e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  Future<void> createUserWithEmailAndPassword() async{
    try{
      await Auth().createUserWithEmailAndPassword(email: _emailController.text, password: _passwordController.text);
    }
    on FirebaseAuthException catch(e){
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  Widget _title(){
    return const Text('Firebase auth');
  }

  Widget _entryField(String title, TextEditingController controller){
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: title,
      ),
    );
  }

  Widget _errorMessage() {
    return Text(errorMessage == '' ? '' : 'Humm ? $errorMessage');
  }

  Widget _submitButton(){
    return ElevatedButton(onPressed: isLogin ? signInWithEmailAndPassword : createUserWithEmailAndPassword,
        child: Text(isLogin? 'Login' : 'Register'));
  }

  Widget _loginOrRegisterButton() {
    return TextButton(
      onPressed: () {setState(() {
      isLogin = !isLogin;
    });},
      child: Text(isLogin? 'Register instead' : 'Login instead'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _title(),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _entryField('email', _emailController),
            _entryField('password', _passwordController),
            _errorMessage(),
            _loginOrRegisterButton(),
            _submitButton(),
            _loginOrRegisterButton()
          ],
        ),
      ),
    );
  }

}