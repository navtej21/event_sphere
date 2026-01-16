import 'package:event_sphere/services/auth_service.dart';
import 'package:flutter/material.dart';
import '../../models/user_role.dart';

class RegisterScreen extends StatefulWidget {
  final String email;
  const RegisterScreen({super.key, required this.email});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final password = TextEditingController();

  UserRole selectedRole = UserRole.ATTENDEE;

  bool loading = false;
  bool hidePassword = true;

  Future<void> register() async {
    if (firstName.text.isEmpty ||
        lastName.text.isEmpty ||
        password.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill all fields")),
      );
      return;
    }

    setState(() => loading = true);

    final success = await AuthService.register(
      name: "${firstName.text.trim()} ${lastName.text.trim()}",
      email: widget.email,
      password: password.text,
      role: selectedRole, // 👈 role from dropdown
    );

    setState(() => loading = false);

    if (success && mounted) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F7F2),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Title
              const Text(
                "Create an account",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w800,
                ),
              ),

              const SizedBox(height: 12),

              /// Email (read-only)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.black12.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  widget.email,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                  ),
                ),
              ),

              const SizedBox(height: 16),

              /// Role dropdown
              DropdownButtonFormField<UserRole>(
                value: selectedRole,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide.none,
                  ),
                ),
                items: UserRole.values
                    .where((role) => role != UserRole.ADMIN) // 🚫 no admin
                    .map((role) {
                  return DropdownMenuItem(
                    value: role,
                    child: Text(
                      role.name[0] +
                          role.name.substring(1).toLowerCase(),
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() => selectedRole = value!);
                },
              ),

              const SizedBox(height: 20),

              /// First name
              _inputField(
                controller: firstName,
                hint: "First name",
              ),

              const SizedBox(height: 12),

              /// Last name
              _inputField(
                controller: lastName,
                hint: "Last name",
              ),

              const SizedBox(height: 12),

              /// Password
              _inputField(
                controller: password,
                hint: "Password",
                obscure: hidePassword,
                suffix: IconButton(
                  icon: Icon(
                    hidePassword
                        ? Icons.visibility_off
                        : Icons.visibility,
                  ),
                  onPressed: () {
                    setState(() => hidePassword = !hidePassword);
                  },
                ),
              ),

              const SizedBox(height: 12),

              /// Terms text
              const Text(
                "By signing up, you agree to our Terms of Service and Privacy Policy.",
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.black54,
                ),
              ),

              const Spacer(),

              /// Sign Up button
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: loading ? null : register,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28),
                    ),
                  ),
                  child: loading
                      ? const SizedBox(
                          width: 22,
                          height: 22,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : const Text(
                          "Sign Up",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                ),
              ),

              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _inputField({
    required TextEditingController controller,
    required String hint,
    bool obscure = false,
    Widget? suffix,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscure,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Colors.white,
        suffixIcon: suffix,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
