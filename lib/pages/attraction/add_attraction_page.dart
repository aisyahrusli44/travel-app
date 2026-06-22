import 'package:flutter/material.dart';
import '../../services/firestore_service.dart';

class AddAttractionPage extends StatefulWidget {
  const AddAttractionPage({super.key});

  @override
  State<AddAttractionPage> createState() =>
      _AddAttractionPageState();
}

class _AddAttractionPageState
    extends State<AddAttractionPage> {

  final nameController = TextEditingController();
  final categoryController = TextEditingController();
  final descriptionController = TextEditingController();

  final FirestoreService firestoreService =
      FirestoreService();

  Future<void> saveAttraction() async {

    await firestoreService.addAttraction(
      name: nameController.text,
      category: categoryController.text,
      description: descriptionController.text,
    );

    if (mounted) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Attraction"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [

            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: "Attraction Name",
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: categoryController,
              decoration: const InputDecoration(
                labelText: "Category",
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(
                labelText: "Description",
              ),
            ),

            const SizedBox(height: 25),

            ElevatedButton(
              onPressed: saveAttraction,
              child: const Text("Save"),
            ),
          ],
        ),
      ),
    );
  }
}