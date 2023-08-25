import 'package:flutter/material.dart';
import 'package:flutter_graphql_testapp/constanta.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class EditMutation extends StatefulWidget {
  const EditMutation({
    super.key,
    required this.id,
    required this.updatedDescription,
    required this.updatedTitle,
  });
  final String id;
  final String updatedTitle;
  final String updatedDescription;

  @override
  State<EditMutation> createState() => _EditMutationState();
}

class _EditMutationState extends State<EditMutation> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    titleController.text = widget.updatedTitle;
    descriptionController.text = widget.updatedDescription;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update note'),
      ),
      body: Column(
        children: [
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Title',
            ),
            controller: titleController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a title';
              }
              return null;
            },
          ),
          TextFormField(
            maxLines: 3,
            decoration: const InputDecoration(
              labelText: 'Description',
            ),
            controller: descriptionController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a description';
              }
              return null;
            },
          ),
          Mutation(
            options: MutationOptions(document: gql(updateNote)),
            builder: (
              RunMutation runMutation,
              QueryResult? result,
            ) {
              return ElevatedButton(
                onPressed: () {
                  runMutation({
                    'id': widget.id,
                    'title': titleController.text,
                    'description': descriptionController.text,
                  });
                  Navigator.pop(context);
                },
                child: const Text('Update'),
              );
            },
          ),
        ],
      ),
    );
  }
}
