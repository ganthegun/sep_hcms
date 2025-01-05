import 'package:flutter/material.dart';
import 'package:sep_hcms/view/page/booking/activityupdateform.dart';

class ActivityUpdatePage extends StatefulWidget {
  const ActivityUpdatePage({super.key});

  @override
  State<ActivityUpdatePage> createState() => _ActivityUpdatePageState();
}

class _ActivityUpdatePageState extends State<ActivityUpdatePage> {
  List<Map<String, dynamic>> activities = [
    {
      'address': 'No 8, Taman Beruas',
      'status': 'INCOMPLETE',
      'image': Icons.home,
    },
    {
      'address': 'No 6, Jalan 51/215 Seksyen 51',
      'status': 'DONE',
      'image': Icons.home,
    },
    {
      'address': 'No 9, Jalan 51/215 Seksyen 51',
      'status': 'DONE',
      'image': Icons.home,
    },
  ];

  // Function to add activity
  void addActivity(Map<String, dynamic> activity) {
    setState(() {
      activities.insert(0, activity); // Insert activity at the top of the list
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Activity Update'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: activities.length,
          itemBuilder: (context, index) {
            final activity = activities[index];
            return Card(
              color: activity['status'] == 'DONE'
                  ? Colors.green[100]
                  : Colors.red[100],
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: ListTile(
                leading: Icon(
                  activity['image'] ?? Icons.image,
                  color: Colors.blue,
                  size: 40,
                ),
                title: Text(
                  'Address: ${activity['address']}',
                  style: const TextStyle(fontSize: 16),
                ),
                subtitle: Text(
                  'Status: ${activity['status']}',
                  style: TextStyle(
                    color: activity['status'] == 'DONE'
                        ? Colors.green[900]
                        : Colors.red[900],
                  ),
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (BuildContext context) {
              return ActivityUpdateForm(
                onSave: addActivity, // Add callback to save activity
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.update),
            label: "Updates",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
