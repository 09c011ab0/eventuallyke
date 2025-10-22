import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';
import '../../payments/payment_service.dart';
import '../../reviews/models/review.dart';
import '../../reviews/providers/review_providers.dart';

import '../providers/event_providers.dart';

class EventDetailScreen extends ConsumerWidget {
  const EventDetailScreen({super.key, required this.eventId});

  final String eventId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final event = ref.watch(eventByIdProvider(eventId));
    if (event == null) {
      return Scaffold(
        appBar: AppBar(),
        body: const Center(child: Text('Event not found')),
      );
    }

    final dateStr = DateFormat('EEE, MMM d • h:mm a').format(event.start);

    return Scaffold(
      appBar: AppBar(
        title: Text(event.title),
        actions: [
          IconButton(
            onPressed: () {
              Share.share('Check out ${event.title} in ${event.city} on $dateStr');
            },
            icon: const Icon(Icons.share),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.network(event.coverImageUrl, fit: BoxFit.cover),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Icon(Icons.place),
              const SizedBox(width: 8),
              Text('${event.locationName}, ${event.city}'),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.schedule),
              const SizedBox(width: 8),
              Text(dateStr),
            ],
          ),
          const SizedBox(height: 16),
          if (event.description != null) Text(event.description!),
          const SizedBox(height: 24),
          FilledButton.icon(
            onPressed: () async {
              try {
                await PaymentService().requestStkPush(
                  phoneE164: '+254700000000',
                  amountKes: event.price ?? 0,
                  description: 'Tickets for ${event.title}',
                );
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('STK push initiated. Complete on your phone.')),
                  );
                }
              } catch (e) {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Payment error: $e')),
                  );
                }
              }
            },
            icon: const Icon(Icons.shopping_bag),
            label: const Text('Get Tickets'),
          ),
          const SizedBox(height: 8),
          OutlinedButton.icon(
            onPressed: () {
              // Placeholder for directions
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Map / Directions not implemented yet')),
              );
            },
            icon: const Icon(Icons.directions),
            label: const Text('Directions'),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Ratings & Reviews', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              FilledButton.tonal(
                onPressed: () => _showAddReviewDialog(context, ref, eventId),
                child: const Text('Write Review'),
              ),
            ],
          ),
          const SizedBox(height: 8),
          _ReviewsList(eventId: eventId),
        ],
      ),
    );
  }
}

class _ReviewsList extends ConsumerWidget {
  const _ReviewsList({required this.eventId});
  final String eventId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reviews = ref.watch(reviewsForEventProvider(eventId));
    if (reviews.isEmpty) {
      return const Text('No reviews yet. Be the first!');
    }
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: reviews.length,
      separatorBuilder: (_, __) => const Divider(height: 24),
      itemBuilder: (context, index) {
        final r = reviews[index];
        return ListTile(
          contentPadding: EdgeInsets.zero,
          leading: CircleAvatar(child: Text(r.userName.substring(0, 1).toUpperCase())),
          title: Row(
            children: [
              Text(r.userName, style: const TextStyle(fontWeight: FontWeight.w600)),
              const SizedBox(width: 8),
              Row(
                children: List.generate(
                  5,
                  (i) => Icon(
                    i < r.rating ? Icons.star : Icons.star_border,
                    size: 16,
                    color: Colors.amber,
                  ),
                ),
              ),
            ],
          ),
          subtitle: Text(r.comment),
        );
      },
    );
  }
}

void _showAddReviewDialog(BuildContext context, WidgetRef ref, String eventId) {
  final formKey = GlobalKey<FormState>();
  int rating = 5;
  final commentCtrl = TextEditingController();
  String userName = 'Guest';

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Write a Review'),
        content: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButtonFormField<int>(
                value: rating,
                decoration: const InputDecoration(labelText: 'Rating'),
                items: [1, 2, 3, 4, 5]
                    .map((e) => DropdownMenuItem(value: e, child: Text('$e')))
                    .toList(),
                onChanged: (v) => rating = v ?? 5,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Your name'),
                initialValue: userName,
                onChanged: (v) => userName = v,
              ),
              TextFormField(
                controller: commentCtrl,
                decoration: const InputDecoration(labelText: 'Comment'),
                maxLines: 3,
                validator: (v) => v == null || v.isEmpty ? 'Please add a comment' : null,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Cancel')),
          FilledButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                ref.read(addReviewProvider)(Review(
                  eventId: eventId,
                  userName: userName,
                  rating: rating,
                  comment: commentCtrl.text.trim(),
                  createdAt: DateTime.now(),
                ));
                Navigator.of(context).pop();
              }
            },
            child: const Text('Submit'),
          ),
        ],
      );
    },
  );
}

// Typed route removed; using path parameter route in AppRouter
