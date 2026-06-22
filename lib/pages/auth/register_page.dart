import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() =>
      _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool isLoading = false;

  Future<void> registerUser() async {
    setState(() {
      isLoading = true;
    });

    try {
        UserCredential credential =
            await FirebaseAuth.instance
                .createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );

        await credential.user!.updateDisplayName(
          nameController.text.trim(),
        );

        await credential.user!.reload();
    

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Registration Successful',
          ),
        ),
      );

      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content:
              Text(e.message ?? 'Registration Failed'),
        ),
      );
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Image.asset(
              'assets/images/sabah_bg.jpg',
              fit: BoxFit.cover,
            ),
          ),

          Container(
            color: Colors.black.withOpacity(0.35),
          ),

          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 80),

                  Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    padding: const EdgeInsets.all(25),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.circular(30),
                    ),
                    child: Column(
                      children: [
                        const Text(
                          "Join The Adventure 🌴",
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight:
                                FontWeight.bold,
                            color:
                                Colors.deepPurple,
                          ),
                        ),

                        const SizedBox(height: 25),

                        TextField(
                          controller:
                              nameController,
                          decoration:
                              InputDecoration(
                            prefixIcon:
                                const Icon(
                                    Icons.person),
                            hintText:
                                "Full Name",
                            border:
                                OutlineInputBorder(
                              borderRadius:
                                  BorderRadius
                                      .circular(
                                          15),
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),

                        TextField(
                          controller:
                              emailController,
                          decoration:
                              InputDecoration(
                            prefixIcon:
                                const Icon(
                                    Icons.email),
                            hintText:
                                "Email",
                            border:
                                OutlineInputBorder(
                              borderRadius:
                                  BorderRadius
                                      .circular(
                                          15),
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),

                        TextField(
                          controller:
                              passwordController,
                          obscureText: true,
                          decoration:
                              InputDecoration(
                            prefixIcon:
                                const Icon(
                                    Icons.lock),
                            hintText:
                                "Password",
                            border:
                                OutlineInputBorder(
                              borderRadius:
                                  BorderRadius
                                      .circular(
                                          15),
                            ),
                          ),
                        ),

                        const SizedBox(height: 25),

                        SizedBox(
                          width:
                              double.infinity,
                          height: 55,
                          child:
                              ElevatedButton(
                            onPressed:
                                isLoading
                                    ? null
                                    : registerUser,
                            style:
                                ElevatedButton
                                    .styleFrom(
                              backgroundColor:
                                  Colors
                                      .deepPurple,
                            ),
                            child: isLoading
                                ? const CircularProgressIndicator(
                                    color:
                                        Colors.white,
                                  )
                                : const Text(
                                    "Create Account",
                                    style:
                                        TextStyle(
                                      color: Colors
                                          .white,
                                    ),
                                  ),
                          ),
                        ),

                        const SizedBox(height: 20),

                        const Text(
                          "Already have an account?",
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),

                        TextButton(
                          onPressed: () {
                            Navigator.pop(
                                context);
                          },
                          child: const Text(
                            "Login",
                            style: TextStyle(
                              fontWeight:
                                  FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}