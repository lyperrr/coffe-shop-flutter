import 'package:flutter/material.dart';
import '../../constants/colors.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/custom_button.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

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
              "REGISTER",
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5,
              ),
            ),
          ),
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Username",
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 8),
                const CustomTextField(
                  hint: "Enter your username",
                  icon: Icons.person_outline,
                ),
                const SizedBox(height: 20),
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
                const SizedBox(height: 20),
                const Text(
                  "ConfirmPassword",
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 8),
                const CustomTextField(
                  hint: "Confirm Password",
                  icon: Icons.vpn_key_outlined,
                  obscureText: true,
                ),
                const SizedBox(height: 10),
                Row(
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
                  ],
                ),
                const SizedBox(height: 15),
                CustomButton(
                  text: "Register",
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
