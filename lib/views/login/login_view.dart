import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:go_router/go_router.dart';
import 'dart:math';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView>
    with SingleTickerProviderStateMixin {
  late AnimationController _formController;
  late Animation<double> _formAnimation;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();

  final List<_Particle> _particles = [];
  final Random _random = Random();

  Offset _pointer = Offset(-1, -1); // track finger/mouse

  @override
  void initState() {
    super.initState();

    // Form animation
    _formController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..forward();
    _formAnimation = CurvedAnimation(
      parent: _formController,
      curve: Curves.easeOut,
    );

    // Initialize particles
    for (int i = 0; i < 50; i++) {
      _particles.add(
        _Particle(
          position: Offset(_random.nextDouble(), _random.nextDouble()),
          speed: Offset(
            (_random.nextDouble() - 0.5) * 0.002,
            (_random.nextDouble() - 0.5) * 0.002,
          ),
          size: 2 + _random.nextDouble() * 3,
        ),
      );
    }

    WidgetsBinding.instance.addPostFrameCallback((_) => _animateParticles());
  }

  void _animateParticles() async {
    while (mounted) {
      await Future.delayed(const Duration(milliseconds: 30));
      setState(() {
        for (var p in _particles) {
          // Move particle
          p.position += p.speed;

          // Wrap around screen edges
          if (p.position.dx > 1) p.position = Offset(0, p.position.dy);
          if (p.position.dx < 0) p.position = Offset(1, p.position.dy);
          if (p.position.dy > 1) p.position = Offset(p.position.dx, 0);
          if (p.position.dy < 0) p.position = Offset(p.position.dx, 1);

          // Interactive attraction
          if (_pointer.dx >= 0 && _pointer.dy >= 0) {
            double dx = (_pointer.dx - p.position.dx) * 0.001;
            double dy = (_pointer.dy - p.position.dy) * 0.001;
            p.position += Offset(dx, dy);
          }
        }
      });
    }
  }

  @override
  void dispose() {
    _formController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocus.dispose();
    _passwordFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (details) {
        // Convert global position to normalized 0-1
        final size = MediaQuery.of(context).size;
        _pointer = Offset(
          details.localPosition.dx / size.width,
          details.localPosition.dy / size.height,
        );
      },
      onPanEnd: (_) => _pointer = Offset(-1, -1),
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Stack(
          children: [
            // Lottie background
            SizedBox.expand(
              child: Lottie.network(
                'https://assets6.lottiefiles.com/packages/lf20_ktwnwv5m.json',
                fit: BoxFit.cover,
                repeat: true,
              ),
            ),
            // Interactive particles
            CustomPaint(
              painter: _InteractiveParticlesPainter(_particles),
              child: Container(),
            ),
            // Animated form
            Center(
              child: FadeTransition(
                opacity: _formAnimation,
                child: SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(0, 0.3),
                    end: Offset.zero,
                  ).animate(_formAnimation),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32),
                      child: Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.4),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 20,
                              offset: Offset(0, 10),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text(
                              "Welcome Back",
                              style: TextStyle(
                                fontSize: 32,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 30),
                            // Email
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: _emailFocus.hasFocus
                                      ? Colors.white
                                      : Colors.transparent,
                                  width: 2,
                                ),
                              ),
                              child: TextField(
                                focusNode: _emailFocus,
                                controller: _emailController,
                                style: const TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  hintText: 'Email',
                                  hintStyle: const TextStyle(
                                    color: Colors.white70,
                                  ),
                                  filled: true,
                                  fillColor: Colors.white.withOpacity(0.2),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            // Password
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: _passwordFocus.hasFocus
                                      ? Colors.white
                                      : Colors.transparent,
                                  width: 2,
                                ),
                              ),
                              child: TextField(
                                focusNode: _passwordFocus,
                                controller: _passwordController,
                                obscureText: true,
                                style: const TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  hintText: 'Password',
                                  hintStyle: const TextStyle(
                                    color: Colors.white70,
                                  ),
                                  filled: true,
                                  fillColor: Colors.white.withOpacity(0.2),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 12),
                            // Forgot Password
                            Align(
                              alignment: Alignment.centerRight,
                              child: MouseRegion(
                                cursor: SystemMouseCursors.click,
                                child: GestureDetector(
                                  onTap: () {},
                                  child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 200),
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 4,
                                    ),
                                    child: const Text(
                                      "Forgot Password?",
                                      style: TextStyle(
                                        color: Colors.white70,
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 24),
                            // Login button
                            GestureDetector(
                              onTap: () {
                                GoRouter.of(context).go('/toDoHome');
                              },
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 150),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 60,
                                  vertical: 16,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: .9),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Center(
                                  child: Text(
                                    "Login",
                                    style: TextStyle(
                                      color: Colors.black87,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 24),
                            // Social login
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                _SocialLoginButton(
                                  icon: Icons.g_mobiledata,
                                  label: "Google",
                                  onTap: () {},
                                ),
                                const SizedBox(width: 20),
                                _SocialLoginButton(
                                  icon: Icons.facebook,
                                  label: "Facebook",
                                  onTap: () {},
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Interactive particle model
class _Particle {
  Offset position;
  Offset speed;
  double size;
  _Particle({required this.position, required this.speed, required this.size});
}

// Particle Painter
class _InteractiveParticlesPainter extends CustomPainter {
  final List<_Particle> particles;
  _InteractiveParticlesPainter(this.particles);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.white.withOpacity(0.3);
    for (var p in particles) {
      canvas.drawCircle(
        Offset(p.position.dx * size.width, p.position.dy * size.height),
        p.size,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _InteractiveParticlesPainter oldDelegate) =>
      true;
}

// Social login button
class _SocialLoginButton extends StatefulWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  const _SocialLoginButton({
    required this.icon,
    required this.label,
    required this.onTap,
    super.key,
  });

  @override
  State<_SocialLoginButton> createState() => _SocialLoginButtonState();
}

class _SocialLoginButtonState extends State<_SocialLoginButton> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: _hover
                ? Colors.white.withOpacity(0.9)
                : Colors.white.withOpacity(0.7),
            borderRadius: BorderRadius.circular(12),
            boxShadow: _hover
                ? [
                    const BoxShadow(
                      color: Colors.black26,
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ]
                : [],
          ),
          child: Row(
            children: [
              Icon(widget.icon, color: Colors.black87),
              const SizedBox(width: 8),
              Text(widget.label, style: const TextStyle(color: Colors.black87)),
            ],
          ),
        ),
      ),
    );
  }
}
