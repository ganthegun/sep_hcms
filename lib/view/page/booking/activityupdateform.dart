import 'package:flutter/material.dart';

class ActivityUpdateForm extends StatefulWidget {
  final Function(Map<String, dynamic>) onSave;

  const ActivityUpdateForm({super.key, required this.onSave});

  @override
  State<ActivityUpdateForm> createState() => _ActivityUpdateFormState();
}

class _ActivityUpdateFormState extends State<ActivityUpdateForm> {
  final addressController = TextEditingController();
  final notesController = TextEditingController();
  final Map<String, bool> rooms = {
    "Kitchen": false,
    "Dining Room": false,
    "Bedroom": false,
    "Living Room": false,
  };

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Address Field
            TextField(
              controller: addressController,
              decoration: const InputDecoration(labelText: 'Address'),
            ),
            const SizedBox(height: 10),

            // Checkboxes
            const Text("Select Rooms:"),
            Column(
              children: rooms.keys.map((room) {
                return CheckboxListTile(
                  title: Text(room),
                  value: rooms[room],
                  onChanged: (bool? value) {
                    setState(() {
                      rooms[room] = value ?? false;
                    });
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 10),

            // Notes Field
            TextField(
              controller: notesController,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: 'Notes',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),

            // Save Button
            ElevatedButton(
              onPressed: () {
                final newActivity = {
                  'address': addressController.text,
                  'notes': notesController.text,
                  'selectedRooms': rooms.keys
                      .where((room) => rooms[room]!)
                      .toList(), // Only selected rooms
                };

                widget.onSave(newActivity); // Save activity callback
                Navigator.pop(context); // Close bottom sheet
              },
              child: const Text('Save Activity'),
            ),
          ],
        ),
      ),
    );
  }
}
