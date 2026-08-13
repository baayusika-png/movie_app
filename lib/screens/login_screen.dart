import 'package:flutter/material.dart';
import 'package:movie_app/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 9, 10, 10),

      body: Center(
        child: Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(horizontal: 18),
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 40),

          child: Column(
            children: [
              SizedBox(height: 60),
              const Text(
                "MovieHub",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 44,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                "Cinematic discovery awaits.",
                style: TextStyle(color: Colors.white60, fontSize: 18),
              ),

              const SizedBox(height: 65),

              TextField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                style: const TextStyle(color: Colors.white, fontSize: 18),
                decoration: InputDecoration(
                  hintText: "Email Address",
                  hintStyle: const TextStyle(color: Color(0xFFD0C6C6)),

                  prefixIcon: const Icon(
                    Icons.email_outlined,
                    color: Color(0xFFD0C6C6),
                  ),

                  filled: true,
                  fillColor: const Color(0xFF202020),

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide.none,
                  ),

                  contentPadding: const EdgeInsets.symmetric(vertical: 20),
                ),
              ),

              const SizedBox(height: 18),

              TextField(
                controller: passwordController,
                obscureText: obscurePassword,
                style: const TextStyle(color: Colors.white, fontSize: 18),

                decoration: InputDecoration(
                  hintText: "Password",
                  hintStyle: const TextStyle(color: Color(0xFFD0C6C6)),

                  prefixIcon: const Icon(
                    Icons.lock_outline,
                    color: Color(0xFFD0C6C6),
                  ),

                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        obscurePassword = !obscurePassword;
                      });
                    },
                    icon: Icon(
                      obscurePassword
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      color: const Color(0xFFD0C6C6),
                    ),
                  ),

                  filled: true,
                  fillColor: const Color(0xFF202020),

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide.none,
                  ),

                  contentPadding: const EdgeInsets.symmetric(vertical: 20),
                ),
              ),

              const SizedBox(height: 20),

              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    // Forgot password functionality
                  },
                  child: const Text(
                    "Forgot Password?",
                    style: TextStyle(color: Color(0xFFE5D0D0), fontSize: 15),
                  ),
                ),
              ),

              const SizedBox(height: 18),

              SizedBox(
                width: double.infinity,
                height: 58,
                child: ElevatedButton(
                  onPressed: () async {
                    final success = await context
                        .read<AuthProvider>()
                        .loginUser(
                          emailController.text.trim(),
                          passwordController.text.trim(),
                        );

                    if (success) {
                      Navigator.pop(context);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Invalid Email or Password"),
                        ),
                      );
                    }
                  },

                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),

                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Login",
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      SizedBox(width: 12),

                      Icon(Icons.arrow_forward, size: 24),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 60),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "New to MovieHub? ",
                    style: TextStyle(color: Color(0xFFD0C6C6), fontSize: 15),
                  ),

                  GestureDetector(
                    onTap: () {},
                    child: const Text(
                      "Register",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
