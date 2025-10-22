import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomTextButton extends StatefulWidget {
  final String text;
  final String navigateTo;
  final bool isForLogin;
  const CustomTextButton({
    super.key,
    this.text = "Sign Up",
    required this.navigateTo,
    this.isForLogin = false,
  });

  @override
  State<CustomTextButton> createState() => _CustomTextButtonState();
}

class _CustomTextButtonState extends State<CustomTextButton>
    with SingleTickerProviderStateMixin {
  double _scale = 1.0;

  void _onTapDown(TapDownDetails details) {
    setState(() => _scale = 0.95); // Shrink slightly on press
  }

  void _onTapUp(TapUpDetails details) {
    setState(() => _scale = 1.0);
  }

  void _onTapCancel() {
    setState(() => _scale = 1.0);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: (details) {
        _onTapUp(details);
        context.go(widget.navigateTo); // Navigate on tap
      },
      onTapCancel: _onTapCancel,
      child: AnimatedScale(
        scale: _scale,
        duration: const Duration(milliseconds: 100),
        curve: Curves.easeInOut,
        child: RichText(
          text: TextSpan(
            text: widget.isForLogin
                ? 'Already have and account?'
                : "Don't have an account? ",
            style: const TextStyle(color: Colors.white70, fontSize: 14),
            children: [
              TextSpan(
                text: widget.text,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
