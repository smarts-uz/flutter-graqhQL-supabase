// ignore_for_file: void_checks, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_graphql_testapp/constanta.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class AddNoteScreen extends StatefulWidget {
  const AddNoteScreen({super.key});

  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Note'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Title',
                ),
                controller: _titleController,
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
                controller: _descriptionController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              Mutation(
                options: MutationOptions(
                  document: gql(addNote),
                  update: (GraphQLDataProxy cache, QueryResult? result) {
                    return cache;
                  },
                  onCompleted: (dynamic resultData) {
                    print(resultData);
                  },
                ),
                builder: (
                  RunMutation runMutation,
                  QueryResult? result,
                ) {
                  return ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        runMutation({
                          'title': _titleController.text,
                          'description': _descriptionController.text,
                        });
                        Navigator.pop(context);
                      }
                    },
                    child: const Text('Add Note'),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
