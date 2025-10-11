import 'package:flutter/material.dart';

class OrganizerDashboardScreen extends StatelessWidget {
  const OrganizerDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Organizer Dashboard')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ListTile(
            leading: const Icon(Icons.add_box_outlined),
            title: const Text('Create Event'),
            subtitle: const Text('Publish a new event'),
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const CreateEventScreen()),
            ),
          ),
          const Divider(),
          const ListTile(
            leading: Icon(Icons.analytics_outlined),
            title: Text('Insights'),
            subtitle: Text('Track views, favorites, and check-ins'),
          ),
        ],
      ),
    );
  }
}

class CreateEventScreen extends StatefulWidget {
  const CreateEventScreen({super.key});

  @override
  State<CreateEventScreen> createState() => _CreateEventScreenState();
}

class _CreateEventScreenState extends State<CreateEventScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleCtrl = TextEditingController();
  final _cityCtrl = TextEditingController();
  final _venueCtrl = TextEditingController();

  @override
  void dispose() {
    _titleCtrl.dispose();
    _cityCtrl.dispose();
    _venueCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Event')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _titleCtrl,
                decoration: const InputDecoration(labelText: 'Title'),
                validator: (v) => v == null || v.isEmpty ? 'Required' : null,
              ),
              TextFormField(
                controller: _cityCtrl,
                decoration: const InputDecoration(labelText: 'City'),
                validator: (v) => v == null || v.isEmpty ? 'Required' : null,
              ),
              TextFormField(
                controller: _venueCtrl,
                decoration: const InputDecoration(labelText: 'Venue'),
                validator: (v) => v == null || v.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 16),
              FilledButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Event draft created (stub)')),
                    );
                    Navigator.of(context).pop();
                  }
                },
                child: const Text('Save Draft'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
