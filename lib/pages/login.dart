import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:spark/data/user.dart';
import 'package:spark/pages/home.dart';
import 'package:spark/pages/register.dart';
import 'package:spark/services/auth_service.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final AuthService _authService = AuthService();

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Perform login logic here
      String email = _emailController.text;
      String password = _passwordController.text;

      // Replace this with your login implementation
      print('Login with email: $email, password: $password');
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                
                children: [
                  Image.asset(
                    'assets/icon.png',
                    height: 150,
                  ),
                  const SizedBox(height: 20),
                  Text("Sign in to Spark.",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyLarge),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    style: TextStyle(
                      color: Theme.of(context).textTheme.bodySmall!.color
                    ),
                    decoration: InputDecoration(
                      labelText: 'Username/E-mail',

                      errorStyle: const TextStyle(
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.bold,
                          fontSize: 14),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Theme.of(context).primaryColor,
                          
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your username or e-mail.';
                      }
                      // You can add more email validation here if needed
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    style: TextStyle(
                      color: Theme.of(context).textTheme.bodySmall!.color,
                    ),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      errorStyle: const TextStyle(
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.bold,
                          fontSize: 14),
                      labelText: 'Password',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                          fillColor: Theme.of(context).primaryColorDark
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your password.';
                      }
                      // You can add more password validation here if needed
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      try {
                        UserCredential? userCredential = await _authService.signIn(_emailController.text, _passwordController.text);
                        if (userCredential != null) {
                          print(userCredential.user!.uid);
                          UserLocal loggedInUser = await _authService.getUserData(userCredential.user!.uid);
                          //temporarily just making it the email here cuz i have no idea how we're supposed to fetch the unique username here
                        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Home(user: loggedInUser)));
                        }
                        await _authService.signIn(_emailController.text, _passwordController.text);
                        
                      }

                      catch (e) {
                        print("Error: $e");
                      }

                    },
                    style: ButtonStyle(
                      
                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                        EdgeInsets.all(16)
                      ),
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Theme.of(context).primaryColor)),
                    child: const Text(
                      'Login',
                      style: TextStyle(
                          fontFamily: "Poppins", fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text("Don't have an account?",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontFamily: "Poppins", fontSize: 18)),
                  const SizedBox(height: 20),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => Register()));
                      },
                      child: const Text("Register",
                          style: TextStyle(
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.bold)))
                ],
              ),
            ),
          )),
    );
  }
}
