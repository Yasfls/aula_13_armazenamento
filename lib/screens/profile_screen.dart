import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../models/user_profile.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController nameController =
      TextEditingController();

  final TextEditingController emailController =
      TextEditingController();

  final TextEditingController scoreController =
      TextEditingController();

  late Box<UserProfile> profileBox;

  @override
  void initState() {
    super.initState();

    profileBox = Hive.box<UserProfile>('profileBox');
  }

  @override
  Widget build(BuildContext context) {
    UserProfile? profile;

    if (profileBox.isNotEmpty) {
      profile = profileBox.getAt(0);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil do Usuário'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Nome',
              ),
            ),

            const SizedBox(height: 12),

            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: 'E-mail',
              ),
            ),

            const SizedBox(height: 12),

            TextField(
              controller: scoreController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Pontuação',
              ),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () async {
                final profile = UserProfile(
                  name: nameController.text,
                  email: emailController.text,
                  createdAt: DateTime.now(),
                  score:
                      int.tryParse(scoreController.text) ?? 0,
                );

                await profileBox.clear();
                await profileBox.add(profile);

                setState(() {});
              },
              child: const Text('Salvar Perfil'),
            ),

            const SizedBox(height: 20),

            if (profile != null)
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Text('Nome: ${profile.name}'),
                      Text('E-mail: ${profile.email}'),
                      Text(
                        'Pontuação: ${profile.score}',
                      ),
                      Text(
                        'Cadastro: ${profile.createdAt}',
                      ),
                    ],
                  ),
                ),
              ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () async {
                await profileBox.clear();

                setState(() {});
              },
              child: const Text(
                'Limpar Dados do Perfil',
              ),
            ),
          ],
        ),
      ),
    );
  }
}