// lib/features/home/presentation/pages/home_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hncg_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:hncg_app/features/auth/presentation/bloc/auth_event.dart';
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HNCG Party'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              context.read<AuthBloc>().add(LogoutEvent());
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome to HNCG!',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                children: [
                  _buildFeatureCard(
                    context,
                    icon: Icons.live_tv,
                    label: 'Live Stream',
                    onTap: () => Navigator.pushNamed(context, '/live'),
                  ),
                  _buildFeatureCard(
                    context,
                    icon: Icons.chat,
                    label: 'Chat',
                    onTap: () => Navigator.pushNamed(context, '/chat'),
                  ),
                  _buildFeatureCard(
                    context,
                    icon: Icons.people,
                    label: 'Party',
                    onTap: () => Navigator.pushNamed(context, '/party'),
                  ),
                  _buildFeatureCard(
                    context,
                    icon: Icons.person,
                    label: 'Profile',
                    onTap: () => Navigator.pushNamed(context, '/profile'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureCard(
    BuildContext context, {
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: Theme.of(context).primaryColor),
            const SizedBox(height: 10),
            Text(label, style: Theme.of(context).textTheme.titleMedium),
          ],
        ),
      ),
    );
  }
}