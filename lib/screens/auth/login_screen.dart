import 'package:flutter/material.dart';
import '../../constants/colors.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/custom_button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 180,
            width: double.infinity,
            color: primaryColor,
            alignment: Alignment.center,
            child: const Text(
              "LOGIN",
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5,
              ),
            ),
          ),
          const SizedBox(height: 70),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Email",
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 8),
                const CustomTextField(
                  hint: "example@gmail.com",
                  icon: Icons.person_outline,
                ),
                const SizedBox(height: 20),
                const Text(
                  "Password",
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 8),
                const CustomTextField(
                  hint: "Password",
                  icon: Icons.vpn_key_outlined,
                  obscureText: true,
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Checkbox(value: false, onChanged: (_) {}),
                        const Text(
                          "Remember me?",
                          style: TextStyle(color: secondaryColor),
                        ),
                      ],
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        "Forgot password?",
                        style: TextStyle(color: secondaryColor),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                CustomButton(
                  text: "Login",
                  onPressed: () {
                    print("Login");
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
