import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

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
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Image.asset(
                    'assets/icon.png',
                    height: 150,
                  ),
                  SizedBox(height: 20),
                  Text("Sign in to Spark.",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.displaySmall),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'Username/E-mail',
                      errorStyle: TextStyle(
                          fontFamily: "SF Pro",
                          fontWeight: FontWeight.bold,
                          fontSize: 14),
                      border: OutlineInputBorder(
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
                  SizedBox(height: 20),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    style: TextStyle(fontFamily: "SF Pro"),
                    decoration: InputDecoration(
                      errorStyle: TextStyle(
                          fontFamily: "SF Pro",
                          fontWeight: FontWeight.bold,
                          fontSize: 14),
                      labelText: 'Password',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your password.';
                      }
                      // You can add more password validation here if needed
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _submitForm,
                    child: Text(
                      'Login',
                      style: TextStyle(
                          fontFamily: "SF Pro", fontWeight: FontWeight.bold),
                    ),
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Theme.of(context).primaryColor)),
                  ),
                  SizedBox(height: 20),
                  Text("Don't have an account?",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontFamily: "SF Pro", fontSize: 18)),
                  SizedBox(height: 20),
                  ElevatedButton(
                      onPressed: () {},
                      child: Text("Register",
                          style: TextStyle(
                              fontFamily: "SF Pro",
                              fontWeight: FontWeight.bold)))
                ],
              ),
            ),
          )),
    );
  }
}
